package resp

import (
	"Blogo/model"
	"time"
)

// 后台列表VO
type UserVO struct {
	ID            int          `json:"id"`
	UserInfoID    int          `json:"userInfoID"`
	Avatar        string       `json:"avatar"`
	Nickname      string       `json:"nickname"`
	Roles         []model.Role `json:"roles" gorm:"many2many:user_role;foreignKey:UserInfoId;joinForeignKey:UserId;"`
	LoginType     int          `json:"loginType"`
	IPAddress     string       `json:"IPAddress"`
	IPSource      string       `json:"IPSource"`
	CreatedAt     time.Time    `json:"created_at"`
	LastLoginTime time.Time    `json:"lastLoginTime"`
	IsDisable     bool         `json:"is_ds_disable"`
}

// 登录VO
type LoginVO struct {
	ID            int       `json:"id"`
	UserInfoID    int       `json:"user_info_ID"`
	Avatar        string    `json:"avatar"`
	Username      string    `json:"username"`
	Nickname      string    `json:"nickname"`
	Email         string    `json:"email"`
	Intro         string    `json:"intro"`
	Website       string    `json:"website"`
	LoginType     int       `json:"login_type"`
	IPAddress     string    `json:"ip_address"`
	IPSource      string    `json:"ip_source"`
	LastLoginTime time.Time `json:"last_login_time"`

	// 点赞集合
	ArticleLikeSet []string `json:"article_like_set"`
	CommentLikeSet []string `json:"comment_like_set"`

	Token string `json:"token"`
}

// 在线用户
type UserOnline struct {
	UserInfoID    int       `json:"userInfoID"`
	Nickname      string    `json:"nickname"`
	Avatar        string    `json:"avatar"`
	IPAddress     string    `json:"IPAddress"`
	IPSource      string    `json:"IPSource"`
	Browser       string    `json:"browser"`
	OS            string    `json:"os"`
	LastLoginTime time.Time `json:"lastLoginTime"`
}

// 用户信息VO
type UserInfoVO struct {
	ID       int    `json:"id"`
	Nickname string `json:"nickname"`
	Email    string `json:"email"`
	Avatar   string `json:"avatar"`
	Intro    string `json:"intro"`
	Website  string `json:"website"`
	IPSource string `json:"ip_source"`

	ArticleLikeSet []FrontArticleDetailVO `json:"articleLikeSet"`
	Footstep       []FrontArticleDetailVO `json:"footstep"`
	// CommentLikeSet []string `json:"commentLikeSet"`
	//StarSet        []FrontArticleVO `json:"star_set"`
	Comment []FrontCommentVO `json:"comment"`
	Reply   []ReplyVO        `json:"reply"`
}
