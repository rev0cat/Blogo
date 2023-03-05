package resp

import "Blogo/model"

// 后台首页VO
type BlogHomeVO struct {
	ArticleCount int64 `json:"articleCount"` // 文章数量
	UserCount    int64 `json:"userCount"`    // 用户数量
	MessageCount int64 `json:"messageCount"` // 留言数量
	ViewCount    int64 `json:"viewCount"`    //浏览次数
}

// 前台首页VO
type FrontBlogHomeVO struct {
	ArticleCount  int64                  `json:"articleCount"`  // 文章数量
	UserCount     int64                  `json:"userCount"`     // 用户数量
	MessageCount  int64                  `json:"messageCount"`  // 留言数量
	ViewCount     int                    `json:"viewCount"`     // 浏览次数
	CategoryCount int64                  `json:"categoryCount"` // 分类数量
	TagCount      int64                  `json:"tagCount"`      // 标签数量
	BlogConfig    model.BlogConfigDetail `json:"blogConfig"`    // 博客信息
	//PageList      []model.Page           `json:"pageList"`      //页面列表
	Banners  []model.Banner `json:"banners"`  // 横幅
	Sentence model.Sentence `json:"sentence"` // 句子
}
