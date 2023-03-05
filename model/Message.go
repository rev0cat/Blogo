package model

import "reflect"

// 留言
type Message struct {
	BaseModel
	Nickname  string `gorm:"type:varchar(50);comment:昵称" json:"nickname"`
	Avatar    string `gorm:"type:varchar(255);comment:头像" json:"avatar"`
	IPAddress string `gorm:"type:varchar(50);comment:IP地址" json:"ip_address"`
	IPSource  string `gorm:"type:varchar(50);comment:IP来源" json:"ip_source"`
	Content   string `gorm:"type:varchar(255);comment:留言内容" json:"content"`
	//BulletSpeed string `gorm:"type:tinyint(1);comment:弹幕速度" json:"bullet_speed"`
	IsReview *int8 `gorm:"type:bool;comment:是否审核通过;default:1" json:"is_review"`
	// LikeCount int   `json:"like_count"`
}

func (m *Message) isEmpty() bool {
	return reflect.DeepEqual(m, &Message{})
}
