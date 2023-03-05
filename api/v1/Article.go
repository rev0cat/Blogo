package v1

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

type Article struct{}

func (*Article) AddOrUpdateArticle(c *gin.Context) {
	r.SendCode(c, articleService.AddArticle(
		utils.BindForm[req.AddOrUpdateArticle](c),
		utils.GetFromContext[int](c, "user_info_id")))
}

func (*Article) DeleteArticle(c *gin.Context) {
	r.SendCode(c, articleService.Delete(utils.BindJSON[[]int](c)))
}
