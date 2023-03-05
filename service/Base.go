package service

import "Blogo/dao"

// Redis Key
const (
	KeyUser        = "user:"        // 记录用户
	KeyDelete      = "delete:"      //? 记录强制下线用户?
	KeyAbout       = "about"        // 关于我信息
	KeyBlogConfig  = "blog_config"  // 博客配置信息
	KeyVisitorArea = "visitor_area" // 地域统计
	KeyViewCount   = "view_count"   // 访问数量

	KeyArticleUserLikeSet      = "article_user_like:" // 文章点赞 Set
	KeyArticleLikeCount        = "article_like_count" // 文章点赞数
	KeyArticleViewCount        = "article_view_count" // 文章查看数
	KeyArticleBrowseHistorySet = "article_footstep"   // 文章浏览记录

	KeyCommentUserLikeSet = "comment_user_like:" // 评论点赞 Set
	KeyCommentLikeCount   = "comment_like_count" // 评论点赞数

	KeyMessageUserLikeSet = "message_user_like:" // 留言点赞 Set
	KeyMessageLikeCount   = "message_like_count" // 留言点赞数

	KeyAboutLikeCount = "about_like_count" // 关于页面点赞数
	KeyAboutLikeSet   = "about_like_set"   // 关于页面点赞Set

	KeyPage = "page" // 页面封面

	KeyCarousel = "carousel" // 轮播图
)

var (
	aboutDAO        dao.About
	articleDAO      dao.Article
	categoryDAO     dao.Category
	commentDAO      dao.Comment
	friendLinkDAO   dao.FriendLink
	menuDAO         dao.Menu
	messageDAO      dao.Message
	netdiskDAO      dao.Netdisk
	operationLogDAO dao.OperationLog
	photoDAO        dao.Photo
	resourceDAO     dao.Resource
	roleDAO         dao.Role
	tagDAO          dao.Tag
	userDAO         dao.User
)

var blogInfoService BlogInfo
