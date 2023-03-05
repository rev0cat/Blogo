package resp

import (
	"Blogo/model"
	"time"
)

// 文章列表VO
type ArticleVO struct {
	ID         int            `json:"id"`          // 文章ID
	CreatedAt  time.Time      `json:"created_at"`  // 创建时间
	UpdatedAt  time.Time      `json:"updated_at"`  // 更新时间
	CategoryId int            `json:"category_id"` // 种类ID
	Category   model.Category `gorm:"foreignKey:CategoryId" json:"category"`
	Tags       []model.Tag    `gorm:"many2many:article_tag;joinForeignKey:article_id" json:"tags"`

	UserId      int    `json:"user_id"`
	Title       string `json:"title"`
	Desc        string `json:"desc"`
	Content     string `json:"content"`
	Img         string `json:"img"`
	Type        *int8  `json:"type"`
	Status      *int8  `json:"status"`
	IsTop       *int8  `json:"isTop"`
	IsDelete    *int8  `json:"is_delete"`
	OriginalUrl string `json:"original_url"`

	// 点赞数量
	LikeCount int `json:"like_count"`
	// 浏览次数
	ViewCount int `json:"view_count"`
}

// 文章详情VO
type ArticleDetailVO struct {
	ID           int      `json:"id"`
	Title        string   `json:"title"`
	Desc         string   `json:"desc"`
	Content      string   `json:"content"`
	Img          string   `json:"img"`
	Type         *int8    `json:"type"`
	Status       *int8    `json:"status"`
	IsTop        *int8    `json:"isTop"`
	IsDelete     *int8    `json:"is_delete"`
	OriginalUrl  string   `json:"original_url"`
	CategoryName *string  `json:"category_name"`
	TagNames     []string `json:"tag_names"`
}

// 首页文章VO
// manyToMany 参考: https://gorm.io/zh_CN/docs/many_to_many.html

type FrontArticleVO struct {
	ID         int             `json:"id"`
	CreatedAt  time.Time       `json:"created_at"`
	Title      string          `json:"title"`
	Desc       string          `json:"desc"`
	Content    string          `json:"content"`
	Img        string          `json:"img"`
	Type       *int8           `json:"type"`
	IsTop      *int8           `json:"isTop"`
	Category   *model.Category `json:"category" gorm:"foreignkey:CategoryId;"`
	CategoryId int             `json:"category_id"`
	Tags       []*model.Tag    `gorm:"many2many:article_tag;joinForeignKey:article_id" json:"tags"`
	ReadCount  int             `json:"readCount"`
	Request    string          `json:"request"`
}

// 首页文章详情VO
type FrontArticleDetailVO struct {
	ID        int               `json:"id"`
	CreatedAt model.ArticleTime `json:"created_at"`
	UpdatedAt model.ArticleTime `json:"updated_at"`

	Img         string `json:"img"`
	Title       string `json:"title"`
	Content     string `json:"content"`
	Type        string `json:"type"`
	OriginalUrl string `json:"original_url"`

	CommentCount int    `json:"comment_count"`
	LikeCount    int    `json:"like_count"`
	ViewCount    int    `json:"view_count"`
	WordCount    string `json:"word_count"`

	CategoryId int            `json:"category_id"`
	Category   model.Category `gorm:"foreignkey:CategoryId;" json:"category"`
	Tags       []model.Tag    `gorm:"many2many:article_tag;joinForeignKey:article_id" json:"tags"`

	LastArticle ArticlePaginationVO `gorm:"-" json:"last_article"` // 上一篇文章
	NextArticle ArticlePaginationVO `gorm:"-" json:"next_article"` // 下一篇文章

	RecommendArticles []RecommendArticleVO `json:"recommend_articles" gorm:"-"`
	NewestArticles    []RecommendArticleVO `json:"newest_articles" gorm:"-"`
}

// 文章详情界面: 上一篇文章, 下一篇文章显示
type ArticlePaginationVO struct {
	ID        int               `json:"id"`
	Img       string            `json:"img"`
	Title     string            `json:"title"`
	CreatedAt model.ArticleTime `json:"created_at"`
	ViewCount int               `json:"view_count"`
	LikeCount int               `json:"like_count"`
}

// 推荐文章
type RecommendArticleVO struct {
	ID        int               `json:"id"`
	Img       string            `json:"img"`
	Title     string            `json:"title"`
	CreatedAt model.ArticleTime `json:"created_at"`
	ViewCount int               `json:"view_count"`
	LikeCount int               `json:"like_count"`
}

// 文章归档
type ArchiveVO struct {
	ID        int    `json:"id"`
	Title     string `json:"title"`
	CreatedAt string `json:"created_at"`
}

// 文章归档月份
type ArchiveMonthVO struct {
	ID   string `json:"id"`
	Time string `json:"time"`
}

// ES搜索结果
type ESResultVO struct {
	Hits struct {
		Hits_ []struct {
			Score  float64 `json:"_score"`
			ID     string  `json:"_id"`
			Source struct {
				Content string `json:"content"`
				Title   string `json:"title"`
				// ID      string `json:"id"`
			} `json:"_source"`
			Highlight struct {
				Title   []string `json:"title"`
				Content []string `json:"content"`
			} `json:"highlight"`
		} `json:"hits"`
	} `json:"hits"`
}

// 返回结果
type ReturnSearchResultVO struct {
	ID int `json:"id"`
	//Title     string    `json:"title"`
	//Content   string    `json:"content"`
	Highlight Highlight `json:"highlight"`
	Score     float64   `json:"score"`
}

type Highlight struct {
	Title   string `json:"title"`
	Content string `json:"content"`
}
