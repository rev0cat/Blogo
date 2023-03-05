package resp

import "time"

type ResourceVO struct {
	ID            int          `json:"id"`
	Name          string       `json:"name"`
	Url           string       `json:"url"`
	RequestMethod string       `json:"requestMethod"`
	IsAnonymous   *int8        `json:"isAnonymous"`
	CreatedAt     time.Time    `json:"created_at"`
	Children      []ResourceVO `json:"children"`
}
