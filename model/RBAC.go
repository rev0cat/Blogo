package model

import (
	"reflect"
	"time"
)

// RBAC 权限控制

// 角色
type Role struct {
	BaseModel
	Name      string `gorm:"type:varchar(20);comment:角色名" json:"name"`
	Label     string `gorm:"type:varchar(50);comment:标签" json:"label"`
	IsDisable bool   `gorm:"type:bool;comment:是否禁用" json:"isDisable"`
}

func (r *Role) isEmpty() bool {
	return reflect.DeepEqual(r, &Role{})
}

// 资源
type Resource struct {
	BaseModel `mapstructure:",squash"`
	// 资源路径(接口URL)
	Url string `json:"url" `
	// 请求方式
	RequestMethod string `json:"requestMethod" `
	// 资源名(接口名)
	Name string `json:"name" `
	// 父权限id
	ParentId int64 `json:"parentId" `
	// 是否匿名访问(0-否 1-是)
	IsAnonymous *int8 `json:"isAnonymous" `
}

type RoleResource struct {
	// 角色ID
	RoleId int64 `json:"roleId" `
	// 资源ID
	ResourceId int64 `json:"resourceId" `
}

// 菜单
type Menu struct {
	BaseModel `mapstructure:",squash"`
	// 菜单名
	Name string `json:"name" `
	// 菜单路径
	Path string `json:"path" `
	// 组件
	Component string `json:"component" `
	// 菜单图标
	Icon string `json:"icon" `
	// 显示排序
	OrderNum int64 `json:"orderNum" `
	// 父菜单id
	ParentId int64 `json:"parentId" `
	// 是否隐藏(0-否 1-是)
	IsHidden *int8 `json:"isHidden" `
	//
	KeepAlive *int8 `json:"keepAlive" `
	// 跳转路径
	Redirect string `json:"redirect" `
}

type UserRole struct {
	// 用户ID
	UserId int `json:"userId" `
	// 角色ID
	RoleId int `json:"roleId" `
}

type RoleMenu struct {
	// 角色ID
	RoleId int64 `json:"roleId" `
	// 菜单ID
	MenuId int64 `json:"menuId" `
}

// 用户信息
type UserAuth struct {
	BaseModel `mapstructure:",squash"`
	// 用户信息ID
	UserInfoId int `json:"user_info_id" `
	// 用户名
	Username string `json:"username" `
	// 密码
	Password string `json:"password" `
	// 登录类型
	LoginType int `json:"login_type" `
	// 登录IP地址
	IPAddress string `json:"ip_address" `
	// IP来源
	IPSource string `json:"ip_source" `
	// 上次登录时间
	LastLoginTime time.Time `json:"last_login_time" `
}

func (u *UserAuth) IsEmpty() bool {
	return reflect.DeepEqual(u, &UserAuth{})
}
