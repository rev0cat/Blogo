package routes

import (
	"Blogo/api/front"
	v1 "Blogo/api/v1"
)

// 前台接口
var (
	fAboutAPI      front.About
	fArticleAPI    front.Article
	fBlogInfoAPI   front.BlogInfo
	fCategoryAPI   front.Category
	fCommentAPI    front.Comment
	fFriendLinkAPI front.FriendLink
	fMessageAPI    front.Message
	fNetdiskAPI    front.Netdisk
	fPageAPI       front.Page
	fPhotoAPI      front.Photo
	fCarouselAPI   front.Carousel
	fTagAPI        front.Tag
	userAuthAPI    v1.UserAuth
	userAPI        v1.User
	uploadAPI      v1.Upload
)

// 后台接口
var (
	ArticleAPI v1.Article
)
