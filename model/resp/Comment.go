package resp

import (
	"Blogo/model"
)

// 后台评论VO
type CommentVO struct {
	ID            int              `json:"id"`
	CreatedAt     model.FormatTime `json:"created_at"`
	Avatar        string           `json:"avatar"`
	Nickname      string           `json:"nickname"`
	ReplyNickname string           `json:"reply_nickname"`
	ArticleTitle  string           `json:"article_title"`
	Content       string           `json:"content"`
	Type          int              `json:"type"`
	IsReview      *int8            `json:"isReview"`
	IPAddress     string           `json:"ipAddress"`
	IPSource      string           `json:"ipSource"`
}

// 前台评论VO
type FrontCommentVO struct {
	ID          int              `json:"id"`
	CreatedAt   model.FormatTime `json:"created_at"`
	UserID      int              `json:"user_id"`
	Avatar      string           `json:"avatar"`
	Nickname    string           `json:"nickname"`
	Content     string           `json:"content"`
	Website     string           `json:"website"`
	LikeCount   int              `json:"like_count"`
	ReplyCount  int              `json:"reply_count"`
	ReplyVOList []ReplyVO        `json:"reply_vo_list" gorm:"-"`
	IPSource    string           `json:"ip_source"`
}

// 评论回复 VO
type ReplyVO struct {
	ID            int              `json:"id"`
	CreatedAt     model.FormatTime `json:"created_at"`
	ParentId      int              `json:"parent_id"`
	UserId        int              `json:"user_id"`
	Nickname      string           `json:"nickname"`
	Avatar        string           `json:"avatar"`
	Website       string           `json:"website"`
	ReplyUserId   int              `json:"reply_user_id"`
	ReplyNickname string           `json:"reply_nickname"`
	ReplyWebsite  string           `json:"reply_website"`
	ReplyCount    int64            `json:"reply_count"`
	ReplyVOList   []ReplyVO        `json:"reply_vo_list" gorm:"-"`
	Content       string           `json:"content"`
	LikeCount     int              `json:"like_count"`
	IPSource      string           `json:"ip_source"`
}
