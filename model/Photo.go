package model

import "time"

type Photo struct {
	ID         int       `json:"id"`
	Created_At time.Time `json:"created__at"`
	Url        string    `json:"url"`
}
