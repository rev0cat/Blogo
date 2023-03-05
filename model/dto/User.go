package dto

import "Blogo/model/resp"

// Session信息
type SessionInfo struct {
	UserDetailDTO
	IsOffline *int8 `json:"isOffline"`
}

// 用户详细信息(仅在后端内部进行传输)
type UserDetailDTO struct {
	resp.LoginVO
	Password   string   `json:"password"`
	IsDisable  bool     `json:"is_disable"`
	Browser    string   `json:"browser"`
	OS         string   `json:"os"`
	RoleLabels []string `json:"roleLabels"`
}
