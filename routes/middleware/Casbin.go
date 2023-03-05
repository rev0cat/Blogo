package middleware

import (
	"Blogo/utils"
	"Blogo/utils/r"

	"github.com/gin-gonic/gin"
)

// Casbin鉴权中间件
func RBAC() gin.HandlerFunc {
	utils.Casbin.LoadPolicy()
	return func(c *gin.Context) {
		role, _ := c.Get("role")
		url, method := c.FullPath()[4:], c.Request.Method
		// 使用Casbin自带的函数执行策略验证
		isPass, err := utils.Casbin.Enforcer().Enforce(role, url, method)
		// 未通过
		if err != nil || !isPass {
			r.SendCode(c, r.ErrorPermissionDenied)
			c.Abort()
			return
		} else {
			c.Next()
		}
	}
}
