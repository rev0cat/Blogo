package front

import (
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type Page struct{}

func (*Page) GetPage(c *gin.Context) {
	r.SuccessData(c, pageService.GetPage())
}
