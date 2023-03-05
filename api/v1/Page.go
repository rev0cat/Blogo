package v1

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type Page struct{}

func (*Page) GetList(c *gin.Context) {
	r.SuccessData(c, pageService.GetList())
}

func (*Page) SaveOrUpdate(c *gin.Context) {
	r.SendCode(c, pageService.SaveOrUpdate(utils.BindJSON[req.AddOrEditPage](c)))
}

func (*Page) Delete(c *gin.Context) {
	r.SendCode(c, pageService.Delete(utils.BindJSON[[]int](c)))
}
