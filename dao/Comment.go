package dao

import (
	"Blogo/model"
	"Blogo/model/dto"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Comment struct{}

// TODO
//func (*Comment) Save(c model.Comment)  {}

// 获取评论数量
func (*Comment) GetCount(req req.GetComments) int64 {
	var count int64
	tx := DB.Select("COUNT(1)").Table("comment c").
		Joins("LEFT JOIN user_info ui ON c.user_id = ui.id")
	if req.Type != 0 {
		tx = tx.Where("c.type = ?", req.Type)
	}
	if req.IsReview != nil {
		tx = tx.Where("c.is_review = ?", req.IsReview)
	}
	if req.Nickname != "" {
		tx = tx.Where("ui.nickname LIKE ?", "%"+req.Nickname+"%")
	}
	tx.Count(&count)
	return count
}

func (*Comment) GetList(req req.GetComments) []resp.CommentVO {
	list := make([]resp.CommentVO, 0)
	tx := DB.
		Select("c.id, u1.avatar, u1.nickname, u2.nickname reply_nickname, a.title article_title c.content, c.type, c.ip_source, c.ip_address, c.created_at, c.is_review").
		Table("comment c").
		Joins("LEFT JOIN article a ON c.topic_id = a.id").
		Joins("LEFT JOIN user_info u1 ON c.user_id = u1.id").
		Joins("LEFT JOIN user_info u2 ON c.reply_user_id = u2.id")

	if req.Type != 0 {
		tx = tx.Where("c.type = ?", req.Type)
	}
	if req.IsReview != nil {
		tx = tx.Where("c.is_review = ?", req.IsReview)
	}
	if req.Nickname != "" {
		tx = tx.Where("u1.nickname LIKE ?", "%"+req.Nickname+"%")
	}
	tx.Order("id DESC").
		Limit(req.PageSize).
		Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)

	return list
}

// 获取前台评论列表
func (*Comment) GetFrontList(req req.GetFrontComments) ([]resp.FrontCommentVO, int64) {
	list := make([]resp.FrontCommentVO, 0)
	var total int64

	tx := DB.
		Select("u.nickname, u.avatar, u.website, c.id, c.user_id, c.content, c.created_at, c.ip_source").
		Table("comment c").
		Joins("LEFT JOIN user_info u ON c.user_id = u.id").
		Where("c.is_review = 1 AND parent_id = 0")
	if req.TopicID != 0 {
		tx = tx.Where("topic_id", req.TopicID)
	}
	tx.Count(&total).
		Order("c.id DESC").
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)

	return list, total
}

// 根据评论id列表获取回复列表
func (*Comment) GetReplyList(ids []int) []resp.ReplyVO {
	list := make([]resp.ReplyVO, 0)
	DB.
		Select("c.user_id, u1.nickname, u1.avatar, u1.website, c.reply_user_id, u2.nickname AS reply_nickname, "+
			"u2.avatar AS reply_avatar, c.id, c.parent_id, c.content, c.created_at, c.ip_source").
		Table("comment c").
		Joins("JOIN user_info u1 ON c.user_id = u1.id").
		Joins("JOIN user_info u2 ON c.reply_user_id = u2.id").
		Where("c.is_review = 1 AND parent_id IN ?", ids).
		Order("c.parent_id, c.created_at DESC").
		Find(&list)

	return list
}

// 根据parent_ids获取已经审核的回复数量列表
func (*Comment) GetReplyCountListByCommentID(ids []int) []dto.ReplyCountDTO {
	list := make([]dto.ReplyCountDTO, 0)
	DB.
		Select("parent_id AS comment_id, COUNT(1) AS reply_count").
		Table("comment").
		Where("is_review = 1 AND parent_id in ?", ids).
		Group("parent_id").
		Find(&list)
	return list
}

// 根据评论id获取回复列表
func (*Comment) GetReplyListByCommentID(id int, req req.PageQuery) []resp.ReplyVO {
	list := make([]resp.ReplyVO, 0)
	DB.
		Select("c.user_id, u1.nickname, u1.avatar, u1.website, c.reply_user_id, u2.nickname AS reply_nickname, "+
			"u2.avatar AS reply_avatar, c.id, c.parent_id, c.content, c.created_at, c.ip_source").
		Table("comment c").
		Joins("JOIN user_info u1 ON c.user_id = u1.id").
		Joins("JOIN user_info u2 ON c.reply_user_id = u2.id").
		Where("c.is_review = 1 AND parent_id = ?", id).
		Order("c.id DESC").
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)

	return list
}

// 根据评论ID获取楼中楼
func (*Comment) GetFloorReplyByID(id int) ([]resp.ReplyVO, int64) {
	list := make([]resp.ReplyVO, 0)
	var total int64
	DB.
		Select("c.user_id, u1.nickname, u1.avatar, u1.website, u2.nickname AS reply_nickname, "+
			"u2.avatar AS reply_avatar, c.id, c.parent_id, c.content, c.created_at, c.ip_source").
		Table("comment c").
		Joins("JOIN user_info u1 ON c.user_id = u1.id").
		Joins("JOIN user_info u2 ON c.reply_user_id = u2.id").
		Where("c.is_review = 1 AND parent_id = ?", id).
		Order("c.id DESC").
		Count(&total).
		Find(&list)
	return list, total
}

// 查询文章评论数量
func (*Comment) GetArticleCommentCount(articleID int) (count int64) {
	DB.Model(&model.Comment{}).
		Where("topic_id = ? AND is_review = 1", articleID).
		Count(&count)
	return
}
