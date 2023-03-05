package resp

import (
	"Blogo/model"
)

type MessageListVO struct {
	MessageList []FrontMessageVO `json:"message_list"`
	Total       int64            `json:"total"`
}

type MessageVO struct {
	model.BaseModel
	Nickname  string `gorm:"type:varchar(50);comment:昵称" json:"nickname"`
	Avatar    string `gorm:"type:varchar(255);comment:头像" json:"avatar"`
	IPAddress string `gorm:"type:varchar(50);comment:IP地址" json:"ip_address"`
	IPSource  string `gorm:"type:varchar(50);comment:IP来源" json:"ip_source"`
	Content   string `gorm:"type:varchar(255);comment:留言内容" json:"content"`
	IsReview  *int8  `gorm:"type:bool;comment:是否审核通过;default:0" json:"is_review"`
	LikeCount int    `json:"like_count"`
}

type FrontMessageVO struct {
	ID        int              `json:"id"`
	CreatedAt model.FormatTime `json:"created_at"`
	Nickname  string           `gorm:"type:varchar(50);comment:昵称" json:"nickname"`
	Avatar    string           `gorm:"type:varchar(255);comment:头像" json:"avatar"`
	IPAddress string           `gorm:"type:varchar(50);comment:IP地址" json:"ip_address"`
	IPSource  string           `gorm:"type:varchar(50);comment:IP来源" json:"ip_source"`
	Content   string           `gorm:"type:varchar(255);comment:留言内容" json:"content"`
	IsReview  *int8            `gorm:"type:bool;comment:是否审核通过;default:0" json:"is_review"`
	LikeCount int              `json:"like_count"`
}
