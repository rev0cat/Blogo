package model

import "reflect"

// 种类
type Category struct {
	BaseModel

	Name    string    `gorm:"type:varchar(20);not null;comment:分类名称" json:"name"`
	Article []Article `gorm:"foreignKey:CategoryID"` // 外键
}

// 是否为空
func (c *Category) IsEmpty() bool {
	return reflect.DeepEqual(c, &Category{})
}
