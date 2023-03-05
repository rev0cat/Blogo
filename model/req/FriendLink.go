package req

// 新建或更新友链
type AddOrUpdateFriendLink struct {
	ID      int    `json:"id"`
	Name    string `json:"name" validate:"required" label:"友链名称"`
	Avatar  string `json:"avatar"`
	Address string `json:"address" validate:"required" label:"友链地址"`
	Intro   string `json:"intro"`
}

// 申请友链
type ApplyFriendLink struct {
	Name    string `json:"name"`
	Intro   string `json:"intro"`
	Address string `json:"address"`
	Avatar  string `json:"avatar"`
}
