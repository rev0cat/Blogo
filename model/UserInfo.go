package model

type UserInfo struct {
	BaseModel
	// 邮箱
	Email string `json:"email" `
	// 昵称
	Nickname string `json:"nickname" `
	// 头像地址
	Avatar string `json:"avatar" `
	// 个人简介
	Intro string `json:"intro" `
	// 个人网站
	Website string `json:"website" `
	// 是否禁用(0-否 1-是)
	IsDisable bool `json:"is_disable" `
}
