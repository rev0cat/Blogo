package model

import "time"

// BaseModel 基础模型
type BaseModel struct {
	ID        int       `json:"id" gorm:"primary_key;auto_increment" mapstructure:"id"`
	CreatedAt time.Time `json:"created_at" mapstructure:"-"`
	UpdatedAt time.Time `json:"updated_at" mapstructure:"-"`
}
