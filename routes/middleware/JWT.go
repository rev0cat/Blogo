package middleware

import (
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
	"strings"
	"time"
)

// JWT中间件
func JWTAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		//if c.Request.Method == "OPTIONS" {
		//	c.Abort()
		//	return
		//}
		// token放在Authorization中，使用Bearer开头
		token := c.Request.Header.Get("Authorization")
		// 判空
		if token == "" {
			r.SendCode(c, r.ErrorTokenNotExist)
			c.Abort()
			return
		}

		// token的格式：`Bearer [tokenString]`
		parts := strings.Split(token, " ")
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			r.SendCode(c, r.ErrorTokenTypeWrong)
			c.Abort()
			return
		}

		// parts[1]为tokenString
		claims, err := utils.GetJWT().ParseToken(parts[1])
		// 解析失败
		if err != nil {
			r.SendData(c, r.ErrorTokenWrong, err.Error())
			c.Abort()
			return
		}

		// 判断是否过期
		if time.Now().Unix() > claims.ExpiresAt.Unix() {
			r.SendCode(c, r.ErrorTokenRuntime)
			c.Abort()
			return
		}

		// 将当前请求信息保存到上下文c中
		// 后续处理函数可以用c.Get("xxx")来获取当前请求的用户信息
		c.Set("user_info_id", claims.UserId)
		c.Set("role", claims.Role)
		c.Set("uuid", claims.UUID)

		c.Next()
	}
}
