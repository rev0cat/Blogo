package req

// 新增留言
type AddMessage struct {
	// Nickname    string `json:"nickname" validate:"required"`
	// Avatar      string `json:"avatar"`
	UserID    int    `json:"user_id"`
	Content   string `json:"content" validate:"required"`
	IPSource  string `json:"ip_source"`
	IPAddress string `json:"ip_address"`
	// BulletSpeed int    `json:"bulletSpeed"`
}

type GetMessages struct {
	PageQuery
	Nickname string `form:"nickname"`
	IsReview *int8  `form:"isReview"`
}
