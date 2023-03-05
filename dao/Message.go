package dao

import (
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Message struct{}

func (*Message) GetList(req req.GetMessages) ([]resp.FrontMessageVO, int64) {
	var list = make([]resp.FrontMessageVO, 0)
	var total int64

	db := DB.Table("message").
		Select("id, nickname, avatar, ip_source, content, created_at").
		Where("is_review = 1")
	if req.Nickname != "" {
		db = db.Where("nickname LIKE ?", "%"+req.Nickname+"%")
	}
	if req.IsReview != nil {
		db = db.Where("is_review = ?", req.IsReview)
	}
	db.Count(&total)
	db.Order("id DESC").
		Limit(req.PageSize).
		Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)
	return list, total
}
