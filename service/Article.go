package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
	"fmt"
	"github.com/go-redis/redis/v9"
	utils2 "gorm.io/gorm/utils"
	"strconv"
	"strings"
)

type Article struct{}

/* 后台接口 */

// 软删除
func (*Article) SoftDelete(ids []int, isDelete *int8) (code int) {
	var isTop int8 = 0
	dao.Updates(&model.Article{
		IsTop:    &isTop,
		IsDelete: isDelete,
	}, "id IN ?", ids)
	return r.OK
}

// 删除
func (*Article) Delete(ids []int) (code int) {
	// 删除关联信息
	dao.Delete(model.ArticleTag{}, "article_id IN ?", ids)
	dao.Delete(model.Article{}, "id IN ?", ids)
	for i := 0; i < len(ids); i++ {
		utils.Elasticsearch.Delete(strconv.Itoa(ids[i]))
	}
	return r.OK
}

func (*Article) UpdateTop(req req.UpdateTopArticle) (code int) {
	article := model.Article{
		BaseModel: model.BaseModel{ID: req.ID},
		IsTop:     req.IsTop,
	}
	dao.Update(&article, "is_top")
	return r.OK
}

// 获取文章列表
func (*Article) GetList(req req.GetArticles) resp.PageResult[[]resp.ArticleVO] {
	articleList, total := articleDAO.GetList(req)

	likeCountMap := utils.Redis.HGetAll(KeyArticleLikeCount) // 点赞数量
	viewCountZ := utils.Redis.ZRangeWithScores(KeyArticleViewCount, 0, -1)
	viewCountMap := getViewCountMap(viewCountZ) // 访问数量

	for i, article := range articleList {
		articleList[i].ViewCount = viewCountMap[article.ID]
		articleList[i].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(article.ID)])
	}
	return resp.PageResult[[]resp.ArticleVO]{
		PageSize: req.PageSize,
		PageNum:  req.PageNum,
		Total:    total,
		List:     articleList,
	}
}

// 添加或修改文章
func (*Article) AddArticle(req req.AddOrUpdateArticle, userID int) int {
	if req.Title == "" || req.Content == "" {
		return r.FAIL
	}
	article := utils.CopyProperties[model.Article](req)
	article.UserId = userID

	// 检查文章是否存在
	if req.ID != 0 {
		dao.Update(&article)
	} else {
		dao.Create(&article)
	}
	//UpdateArticleTag(req, article.ID)
	// Elasticsearch写入
	utils.Elasticsearch.Update(article.Title, article.Content, article.ID)
	return r.OK
}

// 文章标签关联关系
func UpdateArticleTag(req req.AddOrUpdateArticle, articleID int) {
	// 清楚对应的标签关联
	if req.ID != 0 {
		dao.Delete(model.ArticleTag{}, "article_id = ?", req.ID)
	}
	// 遍历
	var articleTags []model.ArticleTag
	for _, tagName := range req.TagNames {
		tag := dao.GetOne(model.Tag{}, "name = ?", tagName)
		// 不存在则创建
		if tag.IsEmpty() {
			tag.Name = tagName
			dao.Create(&tag)
		}
		articleTags = append(articleTags, model.ArticleTag{
			ArticleId: articleID,
			TagId:     tag.ID,
		})
	}
	dao.Create(&articleTags)
}

// 文章分类关联关系
func UpdateArticleCategory(req req.AddOrUpdateArticle, articleID int) model.Category {
	category := dao.GetOne(model.Category{}, "name = ?", req.CategoryName)
	if category.IsEmpty() && req.Status != model.DRAFT {
		category.Name = req.CategoryName
		dao.Create(&category)
	}
	return category
}

// // 删除文章
// func (*Article) DeleteArticle(id int) int {
// 	if id == 0 {
// 		return r.ErrorArticleNotExist
// 	}
// 	// 查询具体文章
// 	article := articleDAO.GetInfoById(id)
// 	if article.ID == 0 {
// 		return r.ErrorArticleNotExist
// 	}
// 	articleDAO.DeleteArticle(id)
// 	return r.OK

// }

/* 前台 */

// 获取前台文章列表
func (*Article) GetFrontList(req req.GetFrontArticles) ([]resp.FrontArticleVO, int64) {
	list, total := articleDAO.GetFrontList(req)
	for i := range list {
		list[i].ReadCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(list[i].ID))
	}
	return list, total
}

// 前台文章详情
func (*Article) GetFrontInfo(id int) (resp.FrontArticleDetailVO, int) {
	// 查询具体文章
	article := articleDAO.GetInfoById(id)
	if article.ID == 0 {
		return resp.FrontArticleDetailVO{}, r.ErrorArticleNotExist
	}
	// 查询推荐文章
	article.RecommendArticles = articleDAO.GetRecommendList(id, 6)
	for i, recommendArticle := range article.RecommendArticles {
		article.RecommendArticles[i].ViewCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(recommendArticle.ID))
		article.RecommendArticles[i].LikeCount = utils.Redis.HGet(KeyArticleLikeCount, strconv.Itoa(recommendArticle.ID))
	}

	// 查询最新文章
	article.NewestArticles = articleDAO.GetNewestList(5)

	for i, newestArticle := range article.NewestArticles {
		article.NewestArticles[i].ViewCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(newestArticle.ID))
		article.NewestArticles[i].LikeCount = utils.Redis.HGet(KeyArticleLikeCount, strconv.Itoa(newestArticle.ID))
	}
	// 更新文章浏览次数
	utils.Redis.ZIncrBy(KeyArticleViewCount, strconv.Itoa(id), 1)
	// 获取上下文章
	article.LastArticle = articleDAO.GetLast(id)
	article.NextArticle = articleDAO.GetNext(id)
	article.LastArticle.ViewCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(article.LastArticle.ID))
	article.LastArticle.LikeCount = utils.Redis.HGet(KeyArticleLikeCount, strconv.Itoa(article.LastArticle.ID))
	article.NextArticle.ViewCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(article.NextArticle.ID))
	article.NextArticle.LikeCount = utils.Redis.HGet(KeyArticleLikeCount, strconv.Itoa(article.NextArticle.ID))
	// 点赞量，浏览量，字数
	article.ViewCount = utils.Redis.ZScore(KeyArticleViewCount, strconv.Itoa(id))
	article.LikeCount = utils.Redis.HGet(KeyArticleLikeCount, strconv.Itoa(id))
	WordCount := len(strings.TrimSpace(article.Content))
	if WordCount >= 1000 {
		var WordCountK = float64(WordCount) / 1000
		article.WordCount = fmt.Sprintf("%3.1fK", WordCountK)
	} else {
		article.WordCount = strconv.Itoa(WordCount)
	}
	// 评论数量
	article.CommentCount = int(commentDAO.GetArticleCommentCount(id))
	return article, r.OK
}

// 获取点赞数量Map
func getViewCountMap(rz []redis.Z) map[int]int {
	m := make(map[int]int)
	for _, article := range rz {
		id, _ := strconv.Atoi(article.Member.(string))
		m[id] = int(article.Score)
	}
	return m
}

// 获取前台文章归档
// 按前端要求返回嵌套数组
func (*Article) GetArchiveList(req req.GetFrontArticles) ([][]resp.ArchiveVO, []resp.ArchiveMonthVO) {
	ArchiveList := make([][]resp.ArchiveVO, 0)
	MonthList := make([]resp.ArchiveMonthVO, 0)
	AddedMonth := make([]string, 0)
	i := -1
	articles, _ := articleDAO.GetFrontList(req)
	for _, article := range articles {
		FormatMonth := article.CreatedAt.Format("2006-01")
		if !utils2.Contains(AddedMonth, FormatMonth) {
			i++
			MonthList = append(MonthList, resp.ArchiveMonthVO{
				ID:   strconv.Itoa(i),
				Time: FormatMonth,
			})
			AddedMonth = append(AddedMonth, FormatMonth)
			ArchiveList = append(ArchiveList, make([]resp.ArchiveVO, 0))
			ArchiveList[i] = append(ArchiveList[i], resp.ArchiveVO{
				ID:        article.ID,
				Title:     article.Title,
				CreatedAt: article.CreatedAt.Format("2006-01-02"),
			})
		} else {
			ArchiveList[i] = append(ArchiveList[i], resp.ArchiveVO{
				ID:        article.ID,
				Title:     article.Title,
				CreatedAt: article.CreatedAt.Format("2006-01-02"),
			})
		}
		////archives := make([]resp.ArchiveVO, 0)
		//archivesMonth := make([]resp.ArchiveMonthVO, 0)
		//addedMonth := make([]string, 0)
		//for i, article := range articles {
		//	if utils2.Contains(addedMonth, article.CreatedAt.Format("061")) {
		//		continue
		//	}
		//	archivesMonth = append(archivesMonth, resp.ArchiveMonthVO{
		//		ID:    strconv.Itoa(i + 1),
		//		Month: article.CreatedAt.Format("2006-01"),
		//	})
		//	addedMonth = append(addedMonth, article.CreatedAt.Format("061"))
		//}
		//for _, article := range articles {
		//	for i, month := range archivesMonth {
		//		if article.CreatedAt.Format("2006-01") == month.Month {
		//			archivesMonth[i].Archives = append(archivesMonth[i].Archives, resp.ArchiveVO{
		//				ID:        article.ID,
		//				Title:     article.Title,
		//				CreatedAt: article.CreatedAt.Format("2006-01-02"),
		//			})
		//		}
		//	}
		//archives = append(archives, resp.ArchiveVO{
		//	ID:        article.ID,
		//	Title:     article.Title,
		//	CreatedAt: article.CreatedAt.Format("2006-01-02"),
		//	MonthID:   article.CreatedAt.Format("061"),
		//})
		//if !utils2.Contains(addedMonth, article.CreatedAt.Format("061")) {
		//	archivesMonth = append(archivesMonth, resp.ArchiveMonthVO{
		//		ID:    article.CreatedAt.Format("061"),
		//		Month: article.CreatedAt.Format("2006-01"),
		//	})
		//   addedMonth = append(addedMonth, article.CreatedAt.Format("061"))
		//}
	}
	return ArchiveList, MonthList

	//return resp.PageResult[[]resp.ArchiveMonthVO]{
	//	Total:    total,
	//	List:     archivesMonth,
	//	PageSize: req.PageSize,
	//	PageNum:  req.PageNum,
	//}
}

// 前台文章点赞
func (*Article) LikeArticle(uid, articleID int) (code int) {
	// 判断是否点过赞
	articleLikeUserKey := KeyArticleUserLikeSet + strconv.Itoa(uid)
	// 已经点赞，再点击取消
	if utils.Redis.SIsMember(articleLikeUserKey, articleID) {
		utils.Redis.SRem(articleLikeUserKey, articleID)
		utils.Redis.HIncrBy(KeyArticleLikeCount, strconv.Itoa(articleID), -1)
	} else {
		utils.Redis.SAdd(articleLikeUserKey, articleID)
		utils.Redis.HIncrBy(KeyArticleLikeCount, strconv.Itoa(articleID), 1)
	}
	return r.OK
}

// 查询是否点赞文章
func (*Article) CheckArticleLike(uid, articleID int) bool {
	articleLikeUserKey := KeyArticleUserLikeSet + strconv.Itoa(uid)
	res := utils.Redis.SIsMember(articleLikeUserKey, articleID)
	return res
}

// 全文搜索，使用ElasticSearch
func (*Article) SearchArticle(req req.SearchArticle) ([]resp.ReturnSearchResultVO, int) {
	if req.Keyword == "" {
		return []resp.ReturnSearchResultVO{}, r.ErrorNoSearchParam
	}
	var ESResult resp.ESResultVO
	var title = ""
	var content = ""
	ReturnResult := make([]resp.ReturnSearchResultVO, 0)
	utils.Json.Unmarshal(utils.Elasticsearch.Search(req.Keyword), &ESResult)
	for i := 0; i < len(ESResult.Hits.Hits_); i++ {
		if len(ESResult.Hits.Hits_[i].Highlight.Title) > 0 {
			title = ESResult.Hits.Hits_[i].Highlight.Title[0]
		} else {
			title = ESResult.Hits.Hits_[i].Source.Title
		}
		if len(ESResult.Hits.Hits_[i].Highlight.Content) > 0 {
			content = ESResult.Hits.Hits_[i].Highlight.Content[0]
		} else {
			content = ESResult.Hits.Hits_[i].Source.Content
		}
		ID, _ := strconv.Atoi(ESResult.Hits.Hits_[i].ID)
		Result := resp.ReturnSearchResultVO{
			ID: ID,
			//Title:   ESResult.Hits.Hits_[i].Source.Title,
			//Content: ESResult.Hits.Hits_[i].Source.Content,
			Highlight: resp.Highlight{
				Title:   title,
				Content: content,
			},
			Score: ESResult.Hits.Hits_[i].Score,
		}
		ReturnResult = append(ReturnResult, Result)
	}
	if len(ReturnResult) == 0 {
		return ReturnResult, r.ErrorArticleNotExist
	}
	return ReturnResult, r.OK
}

func (*Article) AddFootstep(uid, articleID int) {
	articleList, _ := articleDAO.GetList(req.GetArticles{})
	for _, article := range articleList {
		if articleID == article.ID {
			articleBrowseUserKey := KeyArticleBrowseHistorySet + strconv.Itoa(uid)
			utils.Redis.LAdd(articleBrowseUserKey, articleID)
			break
		}
	}
}

func (*Article) DeleteFootstep(uid, articleID int) {
	articleBrowseUserKey := KeyArticleBrowseHistorySet + strconv.Itoa(uid)
	if articleID != 0 {
		utils.Redis.LDelete(articleBrowseUserKey, articleID)
	} else {
		utils.Redis.LClean(articleBrowseUserKey)
	}
}
