package middleware

import (
	"Blogo/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"time"
)

// 日志中间件
func Logger() gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()
		c.Next()
		cost := time.Since(start)
		utils.Logger.Info(c.Request.URL.Path,
			zap.Int("Status", c.Writer.Status()),
			zap.String("Method", c.Request.Method),
			zap.String("Query", c.Request.URL.RawQuery),
			zap.String("IP", c.ClientIP()),
			zap.String("IP-Source", utils.IP.GetIpSourceSimpleIdle(c.ClientIP())),
			zap.String("User-Agent", c.Request.UserAgent()),
			zap.String("Errors", c.Errors.ByType(gin.ErrorTypePrivate).String()),
			zap.Duration("Cost", cost),
		)
	}
}
