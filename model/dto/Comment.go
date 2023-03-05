package dto

// CommentCountDTO 评论数量
type CommentCountDTO struct {
	ID           int `json:"id"`
	CommentCount int `json:"comment_count"`
}

// ReplyCountDTO 回复数量
type ReplyCountDTO struct {
	CommentID  int `json:"commentId"`
	ReplyCount int `json:"replyCount"`
}
