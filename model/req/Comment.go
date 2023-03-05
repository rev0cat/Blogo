package req

// 获取评论
type GetComments struct {
	PageQuery
	Nickname string `form:"nickname"`
	IsReview *int8  `form:"is_review"`
	Type     int    `form:"type"`
	//IPAddress string `form:"ipAddress"`
	//IPSource  string `form:"ipSource"`
}

// 保存评论
type SaveComment struct {
	ReplyUserID int    `json:"reply_user_id" form:"reply_user_id"`
	TopicID     int    `json:"topic_id" form:"topic_id"`
	Content     string `json:"content" form:"content"`
	ParentID    int    `json:"parent_id" form:"parent_id"`
	//Type        int8   `json:"type" form:"type" validate:"required,min=1,max=3" label:"评论类型"`
	IPAddress string `form:"ip_address"`
	IPSource  string `form:"ip_source"`
}

// 获取前台评论
type GetFrontComments struct {
	PageQuery
	ReplyUserID int    `json:"reply_user_id" form:"reply_user_id"`
	TopicID     int    `json:"topicID" form:"topic_id"`
	Content     string `json:"content" form:"content"`
	ParentID    int    `json:"parent_id" form:"parent_id"`
	//Type        int    `json:"type" form:"type"`
	//IPSource    string `form:"ipSource"`
}
