package resp

import "time"

type TagVO struct {
	ID           int       `json:"id"`
	CreatedAt    time.Time `json:"created_at"`
	UpdatedAt    time.Time `json:"updated_at"`
	Name         string    `json:"name"`
	ArticleCount int       `json:"article_count"`
}
