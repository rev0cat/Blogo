package resp

import "time"

// 前后台通用 种类VO
type CategoryVO struct {
	ID           int       `json:"id"`
	Name         string    `json:"name"`
	ArticleCount int       `json:"article_count"`
	CreatedAt    time.Time `json:"created_at"`
	UpdatedAt    time.Time `json:"updated_at"`
}
