package req

// 新增或编辑角色
type AddOrUpdateRole struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	Label       string `json:"label"`
	IsDisable   bool   `json:"isDisable"`
	ResourceIDs []int  `json:"resourceIDs"`
	MenuIDs     []int  `json:"menuIDs"`
}
