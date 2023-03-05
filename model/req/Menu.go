package req

// 新建或更新菜单

type SaveOrUpdateMenu struct {
	ID        int    `json:"id"`
	Name      string `json:"name" mapstructure:"name"`
	Path      string `json:"path" mapstructure:"path"`
	Component string `json:"component" mapstructure:"component"`
	Icon      string `json:"icon" mapstructure:"icon"`
	OrderNum  *int8  `json:"orderNum" validate:"required,min=0" mapstructure:"orderNum"`
	ParentID  int    `json:"parentID" mapstructure:"parentID"`
	IsHidden  *int8  `json:"isHidden" mapstructure:"isHidden"`
	KeepAlive *int8  `json:"keepAlive" mapstructure:"keepAlive"`
	Redirect  string `json:"redirect" mapstructure:"redirect"`
}
