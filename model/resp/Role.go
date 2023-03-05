package resp

import (
	"time"
)

// 角色 + 资源ID列表 + 菜单ID列表
type RoleVO struct {
	ID          int       `json:"id"`
	Name        string    `json:"name"`
	Label       string    `json:"label"`
	CreatedAt   time.Time `json:"created_at"`
	IsDisable   bool      `json:"is_disable"`
	ResourceIDs []int     `json:"resourceIDs" gorm:"-"`
	MenuIDs     []int     `json:"menuIDs" gorm:"-"`
}
