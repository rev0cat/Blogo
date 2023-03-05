package front

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

type Message struct{}

func (*Message) GetFrontList(c *gin.Context) {
	r.SuccessData(c, messageService.GetList(utils.BindQuery[req.GetMessages](c)))
}

// 点赞留言
func (*Message) LikeMessage(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	messageID := utils.GetIntParam(c, "message_id")
	r.SendCode(c, messageService.LikeMessage(uid, messageID))
}

// 查询是否点赞
func (*Message) CheckMessageLike(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	// messageID := utils.GetIntParam(c, "message_id")
	r.SuccessData(c, messageService.CheckMessageLike(uid))
}

// 新增留言
func (*Message) AddMessage(c *gin.Context) {
	request := utils.BindJSON[req.AddMessage](c)
	request.IPAddress = utils.IP.GetIpAddress(c)
	request.IPSource = utils.IP.GetIpSourceSimpleIdle(request.IPAddress)
	r.SendCode(c, messageService.AddMessage(utils.GetFromContext[int](c, "user_info_id"), request))
}
