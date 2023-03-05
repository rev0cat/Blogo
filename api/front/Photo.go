package front

import (
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

type Photo struct{}

func (*Photo) GetPhotoList(c *gin.Context) {
	r.SuccessData(c, photoService.GetList())
}
