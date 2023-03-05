package v1

import (
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type User struct{}

// 更新当前用户信息
func (*User) UpdateCurrentUser(c *gin.Context) {
	currentUser := utils.BindForm[req.UpdateCurrentUser](c)
	currentUser.ID = utils.GetFromContext[int](c, "user_info_id")
	r.SendCode(c, userService.UpdateCurrentUser(currentUser))
}
