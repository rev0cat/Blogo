package req

import "time"

// 增加或编辑种类
type AddOrEditCategory struct {
	ID        int       `json:"id"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
	Name      string    `json:"name" validate:"required,min=1" label:"分类名称"`
}
