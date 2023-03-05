package r

// 错误码汇总
const (
	OK   = 0
	FAIL = 500

	// code= 90`00... 通用错误
	ErrorRequestParam = 9001
	ErrorRequestPage  = 9002
	ErrorInvalidParam = 9003
	ErrorDbOpe        = 9004

	// code 91... 文件相关错误
	ErrorFileUpload  = 9100
	ErrorFileReceive = 9101

	// code= 1000... 用户模块的错误
	ErrorUserNameUsed          = 1001
	ErrorPasswordWrong         = 1002
	ErrorUserNotExist          = 1003
	ErrorUserNoRight           = 1009
	ErrorOldPassword           = 1010
	ErrorWrongVerificationCode = 1011
	ErrorUsernameNotMatchEmail = 1012
	ErrorEmailExist            = 1013
	ErrorEmailFormWrong        = 1014
	ErrorCaptchaWrong          = 1015
	ErrorEmailNotExist         = 1016

	// code = 1200.. 鉴权相关错误
	ErrorTokenNotExist    = 1201
	ErrorTokenRuntime     = 1202
	ErrorTokenWrong       = 1203
	ErrorTokenTypeWrong   = 1204
	ErrorTokenCreate      = 1205
	ErrorPermissionDenied = 1206
	ForceOffline          = 1207
	Logout                = 1208

	// code= 2000... 文章模块的错误
	ErrorArticleNotExist = 2001
	ErrorNoSearchParam   = 2002

	// code= 3000... 分类模块的错误
	ErrorCateNameUsed = 3001
	ErrorCateNotExist = 3002
	ErrorCateArtExist = 3003

	// code= 4000... 标签模块的错误
	ErrorTagExist    = 4001
	ErrorTagNotExist = 4002
	ErrorTagArtExist = 4003

	// code=5000... 评论模块的错误
	ErrorCommentNotExist = 5001
	ErrorCommentFailed   = 5002

	// code=6000... 权限模块的错误
	ErrorResourceNameExist   = 6001
	ErrorResourceNotExist    = 6002
	ErrorResourceUsedByRole  = 6003
	ErrorResourceHasChildren = 6004
	ErrorMenuNameExist       = 6005
	ErrorMenuNotExist        = 6006
	ErrorMenuUsedByRole      = 6007
	ErrorMenuHasChildren     = 6008
	ErrorRoleNameExist       = 60010
	ErrorRoleNotExist        = 60011

	// code=7000 ... 页面模块的错误
	ErrorPageNameExist = 7001

	// code=8000 ... 友链模块的错误
	ErrorFriendLinkExist = 8001
)

var codeMsg = map[int]string{
	OK:   "OK",
	FAIL: "FAIL",

	ErrorRequestParam: "请求参数格式错误",
	ErrorRequestPage:  "分页参数错误",
	ErrorInvalidParam: "不合法的请求参数",
	ErrorDbOpe:        "数据库操作异常",

	ErrorFileReceive: "文件接收失败",
	ErrorFileUpload:  "文件上传失败",

	ErrorUserNameUsed:          "用户名已存在",
	ErrorUserNotExist:          "该用户不存在",
	ErrorPasswordWrong:         "密码错误",
	ErrorUserNoRight:           "该用户无权限",
	ErrorOldPassword:           "旧密码不正确",
	ErrorWrongVerificationCode: "验证码不正确",
	ErrorUsernameNotMatchEmail: "用户名和邮箱不匹配",
	ErrorEmailExist:            "邮箱已注册",
	ErrorEmailFormWrong:        "邮箱格式错误",
	ErrorCaptchaWrong:          "图形验证码错误",
	ErrorEmailNotExist:         "邮箱未注册",

	ErrorTokenNotExist:    "TOKEN 不存在，请重新登陆",
	ErrorTokenRuntime:     "TOKEN 已过期，请重新登陆",
	ErrorTokenWrong:       "TOKEN 不正确，请重新登陆",
	ErrorTokenTypeWrong:   "TOKEN 格式错误，请重新登陆",
	ErrorTokenCreate:      "TOKEN 生成失败",
	ErrorPermissionDenied: "权限不足",
	ForceOffline:          "您已被强制下线",
	Logout:                "您已退出登录",

	ErrorArticleNotExist: "文章不存在",
	ErrorNoSearchParam:   "没有搜索参数",

	ErrorCateNameUsed: "操作失败，分类名已存在",
	ErrorCateNotExist: "操作失败，分类不存在",
	ErrorCateArtExist: "删除失败，分类下存在文章",

	ErrorTagExist:    "操作失败，标签名已存在",
	ErrorTagNotExist: "操作失败，标签不存在",
	ErrorTagArtExist: "删除失败，标签下存在文章",

	ErrorCommentNotExist: "评论不存在",
	ErrorCommentFailed:   "评论失败",

	ErrorResourceNameExist:   "该资源名已经存在",
	ErrorResourceNotExist:    "该资源不存在",
	ErrorResourceHasChildren: "该资源下存在子资源，无法删除",
	ErrorResourceUsedByRole:  "该资源正在被角色使用，无法删除",
	ErrorMenuNameExist:       "该菜单名已经存在",
	ErrorMenuNotExist:        "该菜单不存在",
	ErrorMenuUsedByRole:      "该菜单正在被角色使用，无法删除",
	ErrorMenuHasChildren:     "该菜单下存在子菜单，无法删除",
	ErrorRoleNameExist:       "该角色名已经存在",
	ErrorRoleNotExist:        "该角色不存在",

	ErrorPageNameExist: "该页面名称已经存在",

	ErrorFriendLinkExist: "友链已存在",
}

func GetMsg(code int) string {
	return codeMsg[code]
}

func GetMsgs(codes []int) []string {
	var ret []string
	for _, code := range codes {
		ret = append(ret, codeMsg[code])
	}
	return ret
}
