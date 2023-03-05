package model

// 横幅
type Banner struct {
	ID      int    `json:"id" gorm:"primary_key;auto_increment" mapstructure:"id"`
	Content string `json:"content" gorm:"type:varchar(30);not null;comment:内容"`
}
