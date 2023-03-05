package routes

import (
	"Blogo/config"
	"Blogo/routes/middleware"
	"net/http"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
)

// 后台路由
func BackRouter() http.Handler {
	gin.SetMode(config.Cfg.Server.AppMode)

	r := gin.New()
	r.SetTrustedProxies([]string{"*"})

	// 静态文件服务
	if config.Cfg.Upload.OssType == "local" {
		r.Static("/public", "./public")
		r.StaticFS("/dir", http.Dir("/public")) // public内文件列举展示
	}

	r.Use(middleware.Logger())             // Zap日志中间件
	r.Use(middleware.ErrorRecovery(false)) // 错误处理
	r.Use(middleware.Cors())               // 跨域

	store := cookie.NewStore([]byte(config.Cfg.Session.Salt))

	store.Options(sessions.Options{MaxAge: int(config.Cfg.JWT.Expire) * 3600})
	r.Use(sessions.Sessions(config.Cfg.Session.Name, store))

	// 无需鉴权的接口
	base := r.Group("/api/back")
	{
		base.POST("/login", userAuthAPI.Login) // 后台登录
	}

	// 需要鉴权的接口
	auth := base.Group("")
	// 注意顺序
	auth.Use(middleware.JWTAuth()) // JWT鉴权
	auth.Use(middleware.RBAC())    // Casbin权限
	// auth.Use() // TODO:监听在线用户
	// auth.Use() // TODO:记录操作日志
	{
		// auth.GET...
		article := auth.Group("/article")
		{
			article.POST("", ArticleAPI.AddOrUpdateArticle) // 新增或编辑文章
			article.DELETE("", ArticleAPI.DeleteArticle)    // 删除文章
		}
	}
	return r
}
