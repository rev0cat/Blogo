package front

import (
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type Category struct{}

func (*Category) GetFrontList(c *gin.Context) {
	r.SuccessData(c, categoryService.GetFrontList())
}
