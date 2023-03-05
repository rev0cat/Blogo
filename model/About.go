package model

// 关于
type About struct {
	BaseModel
	QRCode       string `form:"qr_code" json:"qr_code"`
	TeamImg      string `form:"team_img" json:"team_img"`
	FrontendImg  string `form:"frontend_img" json:"frontend_img"`
	BackendImg   string `form:"backend_img" json:"backend_img"`
	FrontendID   string `form:"frontend_id" json:"frontend_id"`
	BackendID    string `form:"backend_id" json:"backend_id"`
	Introduction string `form:"introduction" json:"introduction"`
	Show         string `form:"show" json:"show"`
	Location     string `form:"location" json:"location"`
	Email        string `form:"email" json:"email"`
	LikeCount    int    `form:"like_count" json:"like_count"`
	Dictum       Dictum `form:"dictum" json:"dictum" gorm:"ForeignKey:DictumID"`
	DictumID     int    `form:"dictum_id" json:"dictum_id"`
}

type Dictum struct {
	ID      int    `form:"id" json:"id"`
	Author  string `form:"author" json:"author"`
	Content string `form:"content" json:"content"`
}

type Experience struct {
	ID      int    `form:"id" json:"id"`
	Pic     string `form:"pic" json:"pic"`
	Title   string `form:"title" json:"title"`
	Content string `form:"content" json:"content"`
	AboutID string `form:"about_id" json:"about_id"`
}
