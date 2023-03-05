package resp

import (
	"Blogo/model"
)

type NetdiskResource struct {
	ID        uint             `gorm:"primarykey" json:"id"`
	CreatedAt model.FormatTime `json:"created_at"`
	UpdatedAt model.FormatTime `json:"updated_at"`
	Url       string           `json:"url"`
	Size      string           `json:"size"`
	Title     string           `json:"title"`
	Picture   string           `json:"picture"`
}
