package req

type AddOrUpdateArticle struct {
	ID          int    `form:"id"`
	Title       string `form:"title" validate:"required" label:"文章标题"`
	Desc        string `form:"desc"`
	Content     string `form:"content" validate:"required" label:"博客内容"`
	Img         string `form:"img"`
	Type        int8   `form:"type" validate:"required,min=1,max=3" label:"类型(1-原创 2-转载 3-翻译)"`
	Status      int8   `form:"status" validate:"required,min=1,max=3" label:"状态(1-公开 2-私密 3-评论可见)"`
	IsTop       *int8  `form:"isTop" validate:"required,min=0,max=1" label:"是否置顶(f-否 t-是)"`
	OriginalUrl string `form:"original_url"`

	TagNames     []string `form:"tag_names"`
	TagIDs       []uint   `form:"tag_ids"`
	CategoryID   int      `form:"category_id"`
	CategoryName string   `form:"category_name"`
}

// 条件查询文章
type GetArticles struct {
	PageQuery
	Title      string `form:"title"`
	CategoryID int    `form:"categoryID"`
	TagID      int    `form:"tagID"`
	Type       int8   `form:"type"`
	Status     int8   `form:"status"`
	IsDelete   *int8  `form:"isDelete"`
}

// 修改文章置顶
type UpdateTopArticle struct {
	ID    int   `json:"id"`
	IsTop *int8 `json:"isTop" validate:"required,min=0,max=1" label:"是否置顶"`
}

// 前台条件查询文章
type GetFrontArticles struct {
	PageQuery
	CategoryID int `form:"categoryID"`
	TagID      int `form:"tagID"`
}

type SearchArticle struct {
	Keyword string `json:"keyword"`
}
