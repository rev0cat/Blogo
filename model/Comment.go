package model

type Comment struct {
	BaseModel
	UserID      int    `gorm:"comment:评论用户ID" json:"user_id"`
	ReplyUserID int    `gorm:"comment:回复用户ID" json:"reply_user_id"`
	TopicID     int    `gorm:"comment:主题ID" json:"topic_id"`
	ParentID    int    `gorm:"comment:父评论ID" json:"parent_id"`
	Content     string `gorm:"type:varchar(1000);comment:评论内容" json:"content"`
	//Type        int8   `gorm:"type:tinyint(1);not null;comment:评论类型(1.文章 2.友链 3.说说)" json:"type"`
	IsDelete  *int8  `gorm:"type:bool;not null;default:0;comment:是否删除(0.否 1.是)" json:"is_delete"`
	IsReview  *int8  `gorm:"type:bool;not null;default:0;comment:是否审核(0.否 1.是)" json:"is_review"`
	IPAddress string `json:"ip_address"`
	IPSource  string `json:"ip_source"`
}
