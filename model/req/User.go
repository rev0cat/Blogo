package req

// 后台查询用户
type GetUsers struct {
	PageQuery
	LoginType int8   `form:"loginType"`
	Nickname  string `form:"nickname"`
}

// 后台更新用户
type UpdateUser struct {
	UserInfoID int    `json:"id"`
	Nickname   string `json:"nickname"`
	RoleIDs    []int  `json:"roleIDs"`
}

// 更新当前用户信息
type UpdateCurrentUser struct {
	ID       int    `form:"id"`
	Nickname string `form:"nickname" validate:"required"`
	Avatar   string `form:"avatar"`
	// Intro    string `json:"intro"`
	// Website  string `json:"website"`
	// Email    string `json:"email"`
}

// 修改用户封禁状态
type UpdateUserDisable struct {
	ID        int  `json:"id"`
	IsDisable bool `json:"is_disable" validate:"required,min=0,max=1"`
}

// 注册
type Register struct {
	Username string `json:"username" label:"用户名" form:"username"`
	Password string `json:"password" label:"密码" form:"password"`
	Code     string `json:"code" form:"code"`
	Email    string `json:"email" form:"email"`
}

// 验证码
type VerificationCode struct {
	Email string `json:"email" form:"email"`
}

// 忘记密码
type ForgotPassword struct {
	Email       string `form:"email" json:"email"`
	Code        string `form:"code" json:"code"`
	NewPassword string `form:"new_password" json:"new_password"`
	NewUsername string `form:"new_username" json:"new_username"`
}

// 忘记密码检测邮箱
type FPEmail struct {
	Email string `form:"email" json:"email"`
	Code  string `form:"code" json:"code"`
}

// 登录
type Login struct {
	Username string `json:"username" validate:"required,min=1,max=12" label:"用户名" form:"username"`
	Password string `json:"password" validate:"required,min=4,max=20" label:"密码" form:"password"`
}

// 修改密码
type UpdatePassword struct {
	Username string `json:"username" validate:"required,min=1,max=12" label:"用户名"`
	Password string `json:"password" validate:"required,min=4,max=20" label:"密码"`
	//Code string `json:"code"`
	//TODO:验证码
}

// 修改管理员密码，需要旧密码验证
type UpdateAdminPassword struct {
	OldPassword string `json:"oldPassword"`
	NewPassword string `json:"newPassword"`
}

// 强制下线
type ForceOfflineUser struct {
	UserIndoId int    `json:"userIndoId"`
	IPAddress  string `json:"IPAddress"`
	Browser    string `json:"browser"`
	OS         string `json:"os"`
}
