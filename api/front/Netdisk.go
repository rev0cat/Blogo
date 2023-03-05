package front

import (
	"Blogo/utils"
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

type Netdisk struct{}

func (*Netdisk) GetList(c *gin.Context) {
	r.SuccessData(c, netdiskService.GetList(utils.BindPageQuery(c)))
}
