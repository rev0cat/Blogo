package front

import (
	"Blogo/service"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type About struct{}

// 点赞关于页面
func (*About) LikeAbout(c *gin.Context) {
	userID := utils.GetFromContext[int](c, "user_info_id")
	code, like := aboutService.LikeAbout(userID)
	r.SendData(c, code, like)
}

// 获取关于页面信息
func (*About) GetAbout(c *gin.Context) {
	about := aboutService.GetAbout()
	r.SuccessData(c, about)
}

// 获取关于页面是否点赞
func (*About) GetAboutIsLike(c *gin.Context) {
	isLike := utils.Redis.SIsMember(service.KeyAboutLikeSet, utils.GetFromContext[int](c, "user_info_id"))
	if isLike {
		r.SuccessData(c, true)
	} else {
		r.SuccessData(c, false)
	}
}
