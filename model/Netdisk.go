package model

import (
	"gorm.io/gorm"
)

type Netdisk struct {
	gorm.Model
	Title   string  `json:"title"`
	Size    float32 `json:"size"`
	Url     string  `json:"url"`
	Picture string  `json:"picture"`
}
