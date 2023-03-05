package model

// Page 页面
type Page struct {
	BaseModel
	Name  string `gorm:"type:varchar(20);not null;comment:页面名称" json:"name"`
	Label string `gorm:"type:varchar(30);comment:页面标签" json:"label"`
	Cover string `gorm:"type:varchar(255);not null;comment:封面图" json:"cover"`
}
