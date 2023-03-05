package dao

import (
	"Blogo/model"
)

type FriendLink struct{}

// 获取友链
func (*FriendLink) GetList() (resp []model.FriendLink) {
	DB.Table("friend_link").
		Select("id, name, avatar, intro, address").
		Where("is_review = 1").
		Order("id ASC").
		Find(&resp)
	//if req.Keyword != "" {
	//	tx = tx.Where("name LIKE ?", "%"+req.Keyword+"%")
	//}
	return
}

// 获取申请友链要求
func (*FriendLink) GetRequirements() (resp []model.Requirement) {
	DB.Table("friendlink_requirement").
		Select("id, content").
		Order("id ASC").
		Find(&resp)
	return
}
