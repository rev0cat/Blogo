package req

// 新增或编辑标签
type AddOrUpdateTag struct {
	ID   int    `json:"id"`
	Name string `json:"name" validate:"required" label:"标签名称"`
}
