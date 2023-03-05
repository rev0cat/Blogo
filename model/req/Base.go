package req

// 关键字查询
type KeywordQuery struct {
	Keyword string `json:"keyword"`
}

// 获取数据
type PageQuery struct {
	PageSize int    `json:"page_size" form:"page_size"`
	PageNum  int    `json:"page_num" form:"page_num"`
	Keyword  string `json:"keyword" form:"keyword"`
}

// 软删除请求
type SoftDelete struct {
	IDs      []int `json:"IDs"`
	IsDelete *int8 `json:"isDelete" validate:"required,min=0,max=1"`
}

// 修改审核（批量）
type UpdateReview struct {
	IDs      []int `json:"IDs"`
	IsReview *int8 `json:"isReview" validate:"required,min=0,max=1"`
}
