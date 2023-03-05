package dao

import (
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Article struct{}

/* 后台 */

// 根据ID获取文章详情
func (*Article) GetInfoById(id int) (res resp.FrontArticleDetailVO) {
	DB.Table("article").
		Preload("Category").
		Preload("Tags").
		Where("id= ? AND is_delete = 0 AND status = 1", id).
		First(&res)
	return
}

// 获取文章列表
func (*Article) GetList(req req.GetArticles) ([]resp.ArticleVO, int64) {
	var list = make([]resp.ArticleVO, 0)
	var total int64

	db := DB.Model(model.Article{})

	// 文章标题
	if req.Title != "" {
		db = db.Where("title LIKE ?", "%"+req.Title+"%")
	}
	// 是否删除
	if req.IsDelete != nil {
		db = db.Where("is_delete", req.IsDelete)
	}
	// 状态
	if req.Status != 0 {
		db = db.Where("status", req.Status)
	}
	// 分类
	if req.CategoryID != 0 {
		db = db.Where("category_id", req.CategoryID)
	}
	// 类型
	if req.Type != 0 {
		db = db.Where("type", req.Type)
	}

	db.Preload("Category").
		Preload("Tags").
		// 标签条件查询
		Joins("LEFT JOIN article_tag ON article.id = article_tag.article_id").
		// 去重
		Group("id")

	// 标签条件查询
	if req.TagID != 0 {
		db = db.Where("tag_id", req.TagID)
	}

	db.Count(&total).
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Order("is_top DESC, id DESC").
		Find(&list)
	return list, total
}

// // 删除文章
// func (*Article) DeleteArticle(id int) {
// 	DB.Table("article").
// 		Select("is_delete").
// 		Where("id = ?", id).
// 		Update("is_delete", 1)
// }

/* 前台 */
// 获取文章列表
func (*Article) GetFrontList(req req.GetFrontArticles) ([]resp.FrontArticleVO, int64) {
	list := make([]resp.FrontArticleVO, 0)
	var total int64

	db := DB.Table("article").
		Select("id, title, content, img, type, is_top, created_at, category_id, read_count").
		Where("is_delete = 0 AND status = 1")
	if req.CategoryID != 0 {
		db = db.Where("category_id", req.CategoryID)
	}
	if req.TagID != 0 {
		db.Where("id IN (SELECT article_id FROM article_tag WHERE tag_id = ?)", req.TagID)
	}

	db.Count(&total)
	db.Preload("Tags").
		Preload("Category").
		Order("is_top DESC, id DESC").
		//Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)
	if len(list) > 0 && req.TagID != 0 {
		list[0].Request = "标签——" + GetTagByID(req.TagID)
	}
	if len(list) > 0 && req.CategoryID != 0 {
		list[0].Request = "分类——" + GetCategoryByID(req.CategoryID)
	}
	return list, total
}

// 查询最新的 n 篇文章
func (*Article) GetNewestList(n int) []resp.RecommendArticleVO {
	list := make([]resp.RecommendArticleVO, 0)
	DB.Table("article").
		Select("id, title, img, created_at").
		Where("is_delete = 0 AND status = 1").
		Order("created_at DESC, id ASC").
		Limit(n).Find(&list)

	return list
}

// 查询上一篇文章(id < 当前文章id)
func (*Article) GetLast(id int) (res resp.ArticlePaginationVO) {
	sub := DB.Table("article").
		Select("max(id)").
		Where("id < ?", id)
	DB.Table("article").
		Select("id, title, img, created_at").
		Where("is_delete = 0 AND status = 1 AND id = (?)", sub).
		Limit(1).Find(&res)
	return
}

//查询下一篇文章(id>当前文章id)

func (*Article) GetNext(id int) (res resp.ArticlePaginationVO) {
	DB.Table("article").
		Select("id, title, img, created_at").
		Where("is_delete = 0 AND status = 1 AND id > ?", id).
		Limit(1).Find(&res)
	return
}

// 查询n篇推荐文章(根据标签)
func (*Article) GetRecommendList(id, n int) []resp.RecommendArticleVO {
	list := make([]resp.RecommendArticleVO, 0)

	// sub1: 查出标签id列表
	// SELECT tag_id FROM `article_tag` WHERE `article_id` = ?
	sub1 := DB.Table("article_tag").
		Select("tag_id").
		Where("article_id", id)

	// sub2: 查出这些标签对应的文章id列表(去重且不包括当前文章)
	sub2 := DB.Table("(?) t1", sub1).
		Select("DISTINCT article_id").
		Joins("JOIN article_tag t ON t.tag_id = t1.tag_id").
		Where("article_id != ?", id)
	// 根据文章id列表查出文章信息(前6个)
	DB.Table("(?) t2", sub2).
		Select("id, title, img, created_at").
		Joins("JOIN article a ON t2.article_id = a.id").
		Where("a.is_delete = 0").
		Order("is_top, id DESC").
		Limit(n).Find(&list)

	return list
}
