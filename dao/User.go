package dao

import (
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type User struct{}

func (*User) GetCount(req req.GetUsers) int64 {
	var count int64
	tx := DB.Select("COUNT(1)").Table("user_auth ua").
		Joins("LEFT JOIN user_info ui ON ua.user_info_id = ui.id")
	if req.LoginType != 0 {
		tx = tx.Where("login_type = ?", req.LoginType)
	}
	if req.Nickname != "" {
		tx = tx.Where("nickname LIKE ?", "%"+req.Nickname+"%")
	}
	tx.Count(&count)
	return count
}

func (*User) GetList(req req.GetUsers) []resp.UserVO {
	var list = make([]resp.UserVO, 0)

	table := DB.
		Select("id, avatar, nickname, is_disable").
		Table("user_info")
	if req.LoginType != 0 {
		table = table.Where("id IN (SELECT user_info_id FROM user_auth WHERE login_type = ?)", req.LoginType)
	}
	if req.Nickname != "" {
		table = table.Where("nickname LIKE ?", "%"+req.Nickname+"%")
	}
	table = table.Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1))
	DB.Select("ua_id, user_info_id, avatar, nickname, login_type, ip_address, ip_source, ua.created_at, last_login_time, ui.is_disable").
		Table("(?) ui", table).
		Preload("Roles").
		Joins("LEFT JOIN user_auth ua ON ua.user_info_id = ui.id").
		Find(&list)
	return list
}

// 收藏列表
func (*User) GetStarList(id int) ([]resp.FrontArticleVO, int64) {
	var list = make([]resp.FrontArticleVO, 0)
	var total int64
	//var articleID []int
	//DB.Table("star").
	//	Where("user_id = ?", id).
	//	Select("article_id").
	//	Find(&articleID)
	//List(&list, "*", "", "id IN ?", articleID)
	DB.Table("article").
		Select("id, title, content, img, type, is_top, created_at, updated_at").
		Where("id IN (SELECT article_id FROM star WHERE user_id = ?)", id).
		Preload("Tags").
		Preload("Category").
		Order("id DESC").
		Count(&total).
		Find(&list)
	return list, total
}

// 评论列表
func (*User) GetCommentList(id int) ([]resp.FrontCommentVO, int64) {
	var list = make([]resp.FrontCommentVO, 0)
	var total int64
	DB.Table("comment c").
		Select("c.id, c.user_id, c.content, c.created_at, c.ip_source").
		//Joins("LEFT JOIN user_info u ON c.reply_user_id = u.id").
		Where("c.is_review = 1 AND c.user_id = ?", id).
		Count(&total).
		Find(&list)
	return list, total
}

// 收到的回复
func (*User) GetReplyList(id int) ([]resp.ReplyVO, int64) {
	var list = make([]resp.ReplyVO, 0)
	var total int64
	DB.Table("comment c").
		Select("c.id, c.user_id, c.content, c.created_at, c.ip_source, "+
			"c.parent_id, u.nickname, u.id, u.website, u.avatar").
		Joins("LEFT JOIN user_info u ON c.user_id = u.id").
		Where("c.is_review = 1 AND c.reply_user_id = ?", id).
		Order("c.created_at ASC").
		Count(&total).
		Find(&list)
	return list, total

}

func (*User) GetNicknameAvatar(id int) (string, string) {
	var res model.UserInfo
	DB.Table("user_info").
		Select("id, nickname, avatar").
		Where("id = ?", id).
		First(&res)
	return res.Nickname, res.Avatar
}

// 查询是否封禁
func (*User) CheckUserDisabled(id int) bool {
	var res model.UserInfo
	DB.Table("user_info").
		Select("id, is_disable").
		Where("id = ?", id).
		First(&res)
	return res.IsDisable
}
