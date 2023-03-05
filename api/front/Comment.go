package front

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type Comment struct{}

// 新增评论
func (*Comment) Comment(c *gin.Context) {
	request := utils.BindJSON[req.SaveComment](c)
	request.IPAddress = utils.IP.GetIpAddress(c)
	request.IPSource = utils.IP.GetIpSourceSimpleIdle(request.IPAddress)
	r.SendCode(c, commentService.Comment(utils.GetFromContext[int](c, "user_info_id"), request))
}

// 获取评论列表
func (*Comment) GetFrontList(c *gin.Context) {
	Comments, _ := commentService.GetFrontList(
		utils.BindQuery[req.GetFrontComments](c))
	r.SuccessData(c, Comments)
}

// 点赞评论
func (*Comment) LikeComment(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	commentID := utils.GetIntParam(c, "comment_id")
	r.SendCode(c, commentService.LikeComment(uid, commentID))
}

// 查询是否点赞
func (*Comment) CheckCommentLike(c *gin.Context) {
	uid := utils.GetFromContext[int](c, "user_info_id")
	r.SuccessData(c, commentService.CheckCommentLike(uid))
}

// 根据评论ID获取回复列表
func (*Comment) GetReplyListByCommentID(c *gin.Context) {
	commentID := utils.GetIntParam(c, "comment_id")
	r.SuccessData(c, commentService.GetReplyListByCommentID(commentID, utils.BindPageQuery(c)))
}
