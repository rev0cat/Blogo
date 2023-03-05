package resp

// 分页响应结果
type PageResult[T any] struct {
	PageSize int   `json:"pageSize"`
	PageNum  int   `json:"pageNum"`
	Total    int64 `json:"total"`
	List     T     `json:"pageData"`
}

// 列表响应结果
type ListResult[T any] struct {
	Total int64 `json:"total"`
	List  T     `json:"list"`
}

type TreeOptionVO struct {
	ID       int            `json:"key"`
	Label    string         `json:"label"`
	Children []TreeOptionVO `json:"children"`
}

type OptionVO struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}
