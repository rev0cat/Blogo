package resp

import "time"

// 用户菜单
type UserMenuVO struct {
	ID        int          `json:"id"`
	Name      string       `json:"name"`
	Path      string       `json:"path"`
	Component string       `json:"component"`
	OrderNum  int8         `json:"orderNum"`
	Icon      string       `json:"icon"`
	Children  []UserMenuVO `json:"children"`
	ParentID  int          `json:"parent_id"`
	IsHidden  *int8        `json:"isHidden"`
	KeepAlive *int8        `json:"keepAlive"`
	Redirect  string       `json:"redirect"`
}

type MenuVO struct {
	ID        int          `json:"id"`
	Name      string       `json:"name"`
	Path      string       `json:"path"`
	Component string       `json:"component"`
	OrderNum  int8         `json:"orderNum"`
	Icon      string       `json:"icon"`
	Children  []UserMenuVO `json:"children"`
	ParentID  int          `json:"parent_id"`
	IsHidden  *int8        `json:"isHidden"`
	KeepAlive *int8        `json:"keepAlive"`
	Redirect  string       `json:"redirect"`
	CreatedAt time.Time    `json:"created_at"`
}
