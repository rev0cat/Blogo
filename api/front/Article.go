package front

import (
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

type Article struct{}

// 获取前台文章列表
func (*Article) GetFrontList(c *gin.Context) {
	var Articles struct {
		List  []resp.FrontArticleVO `json:"list"`
		Total int64                 `json:"total"`
	}
	Articles.List, Articles.Total = articleService.GetFrontList(utils.BindQuery[req.GetFrontArticles](c))
	r.SuccessData(c, Articles)
}

// 根据id获取前台文章详情
func (*Article) GetFrontArticleDetail(c *gin.Context) {
	article, code := articleService.GetFrontInfo(utils.GetIntParam(c, "id"))
	r.SendData(c, code, article)
}

// 添加浏览记录
func (*Article) AddFootstep(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	articleID := utils.GetIntParam(c, "article_id")
	articleService.AddFootstep(uid, articleID)
	r.SuccessWithoutData(c)
}

// 删除浏览记录
func (*Article) DeleteFootstep(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	articleID := utils.GetIntParam(c, "article_id")
	articleService.DeleteFootstep(uid, articleID)
	r.SuccessWithoutData(c)
}

// 获取文章归档
func (*Article) GetArchiveList(c *gin.Context) {
	ArchiveList, MonthList := articleService.GetArchiveList(utils.BindQuery[req.GetFrontArticles](c))
	List := [2]any{
		ArchiveList,
		MonthList,
	}
	r.SuccessData(c, List)
}

// 点赞文章
func (*Article) LikeArticle(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	articleID := utils.GetIntParam(c, "article_id")
	r.SendCode(c, articleService.LikeArticle(uid, articleID))
}

// 查询是否点赞
func (*Article) CheckArticleLike(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	articleID := utils.GetIntParam(c, "article_id")
	r.SuccessData(c, articleService.CheckArticleLike(uid, articleID))
}

// 全文搜索
func (*Article) SearchArticle(c *gin.Context) {
	SearchResult, Code := articleService.SearchArticle(utils.BindJSON[req.SearchArticle](c))
	r.SendData(c, Code, SearchResult)
}
