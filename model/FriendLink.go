package model

import (
	"reflect"
)

// 友链
type FriendLink struct {
	BaseModel
	Name    string `gorm:"type:varchar(50)" json:"name"`
	Avatar  string `gorm:"type:varchar(255)" json:"avatar"`
	Address string `gorm:"type:varchar(255)" json:"address"`
	Intro   string `gorm:"type:varchar(255)" json:"intro"`
	//IsReview *int8  `json:"is_review"`
}

// 申请友链要求
type Requirement struct {
	ID      int    `json:"id"`
	Content string `json:"content"`
}

func (f *FriendLink) IsEmpty() bool {
	return reflect.DeepEqual(f, &FriendLink{})
}
