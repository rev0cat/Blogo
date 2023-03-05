package routes

import (
	"Blogo/config"
	"Blogo/routes/middleware"
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
	"net/http"
)

// 前台接口路由
func FrontRouter() http.Handler {
	gin.SetMode(config.Cfg.Server.AppMode)

	r := gin.New()
	r.SetTrustedProxies([]string{"*"})

	if config.Cfg.Upload.OssType == "local" {
		r.Static("/public", "./public")
		r.StaticFS("/dir", http.Dir("./public"))
	}

	if config.Cfg.Server.AppMode == "debug" {
		r.Use(gin.Logger())
	}

	r.Use(middleware.Cors())
	r.Use(middleware.Logger())

	// 基于cookie存储session
	store := cookie.NewStore([]byte(config.Cfg.Session.Salt))

	store.Options(sessions.Options{
		MaxAge: config.Cfg.Session.MaxAge,
	})
	r.Use(sessions.Sessions(config.Cfg.Session.Name, store)) //Session中间件，使用Redis

	// 无需鉴权
	base := r.Group("/api/front")
	{
		base.GET("/home", fBlogInfoAPI.GetFrontHomeInfo)                          // 首页信息
		base.POST("/login", userAuthAPI.Login)                                    // 登录
		base.GET("/logout", userAuthAPI.Logout)                                   // 退出登录
		base.POST("/verification-code", userAuthAPI.SendRegisterVerificationCode) // 发送验证码
		base.POST("/register", userAuthAPI.Register)                              // 注册
		base.POST("/register-check", userAuthAPI.RegisterCheck)                   // 注册检测
		base.POST("/fw-vcode", userAuthAPI.SendForgotPasswordVerificationCode)    // 忘记密码验证码
		base.POST("/forgot-password", userAuthAPI.ForgotPassword)                 // 忘记密码
		base.POST("/fw-check", userAuthAPI.FPCheckCode)                           // 忘记密码检测验证码
		base.GET("/captcha", userAuthAPI.GenerateCaptcha)                         // 生成图形验证码
		base.GET("/show/:source", userAuthAPI.GetCaptchaImg)                      // 获取图形验证码
		base.POST("/verify-captcha", userAuthAPI.VerifyCaptcha)                   // 验证图形验证码
		base.GET("/about", fAboutAPI.GetAbout)                                    // 获取关于页面

		article := base.Group("/article")
		{
			article.GET("/list", fArticleAPI.GetFrontList)         // 前台文章列表
			article.GET("/:id", fArticleAPI.GetFrontArticleDetail) // 前台文章详情
			article.GET("/archive", fArticleAPI.GetArchiveList)    // 前台文章归档
			article.POST("/search", fArticleAPI.SearchArticle)     // 前台全文搜索
		}
		category := base.Group("/category")
		{
			category.GET("/list", fCategoryAPI.GetFrontList) // 前台分类列表
		}
		carousel := base.Group("/carousel")
		{
			carousel.GET("", fCarouselAPI.GetCarousel) // 获取轮播图
		}
		tag := base.Group("/tag")
		{
			tag.GET("/list", fTagAPI.GetFrontList) // 前台标签列表
		}
		friendLink := base.Group("/friend-link")
		{
			friendLink.GET("/list", fFriendLinkAPI.GetFrontList)      // 前台友链列表
			friendLink.POST("/apply", fFriendLinkAPI.ApplyFriendLink) // 前台申请友链
		}
		comment := base.Group("/comment")
		{
			comment.GET("/list", fCommentAPI.GetFrontList) // 评论列表
			comment.GET("/replies/:comment_id")            // 根据评论ID获取回复
		}
		message := base.Group("/message")
		{
			message.GET("/list", fMessageAPI.GetFrontList) // 获取前台留言
		}
		page := base.Group("/page")
		{
			page.GET("", fPageAPI.GetPage) // 获取页面封面
		}
		photo := base.Group("/photo")
		{
			photo.GET("/list", fPhotoAPI.GetPhotoList) // 获取照片列表
		}
		netdisk := base.Group("/netdisk") // 网盘
		{
			netdisk.GET("/list", fNetdiskAPI.GetList) // 网盘资源列表
		}
	}

	// 需要登录
	base.Use(middleware.JWTAuth())
	{
		base.POST("/about-like", fAboutAPI.LikeAbout)                          // 点赞关于页面
		base.POST("/user/info", userAPI.GetInfo)                               // 根据Token获取用户信息
		base.PUT("/user/info", userAPI.UpdateCurrentUser)                      // 根据Token更新用户信息
		base.POST("/upload", uploadAPI.UploadFile)                             // 文件上传
		base.POST("/comment/like/:comment_id", fCommentAPI.LikeComment)        // 点赞评论
		base.POST("/comment/like/list", fCommentAPI.CheckCommentLike)          // 查询评论点赞列表
		base.POST("/footstep/:article_id", fArticleAPI.AddFootstep)            // 添加浏览记录
		base.DELETE("/footstep/:article_id", fArticleAPI.DeleteFootstep)       // 删除浏览记录
		base.POST("/article/like/:article_id", fArticleAPI.LikeArticle)        // 点赞文章
		base.POST("/article/:article_id/islike", fArticleAPI.CheckArticleLike) // 文章是否点赞
		base.POST("/message/like/:message_id", fMessageAPI.LikeMessage)        // 点赞留言
		base.POST("/message/islike", fMessageAPI.CheckMessageLike)             // 留言是否点赞
		base.POST("/message", fMessageAPI.AddMessage)                          // 添加留言
		base.POST("/comment", fCommentAPI.Comment)                             // 前台评论
		base.POST("/about/islike", fAboutAPI.GetAboutIsLike)                   // 获取关于页面是否点赞
	}
	return r
}
