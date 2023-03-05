package front

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type FriendLink struct{}

func (*FriendLink) GetFrontList(c *gin.Context) {
	r.SuccessData(c, friendLinkService.GetFrontList())
}

func (*FriendLink) ApplyFriendLink(c *gin.Context) {
	r.SendCode(c, friendLinkService.ApplyFriendLink(utils.BindJSON[req.ApplyFriendLink](c)))
}
