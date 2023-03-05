package service

import (
	"Blogo/config"
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/dto"
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
	"bytes"
	"github.com/dchest/captcha"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"sort"
	"strconv"
	"strings"
	"time"
)

type User struct{}

/* 前台 */

// 登录
func (*User) Login(c *gin.Context, username, password string) (loginVO resp.LoginVO, code int) {
	if username == "" || password == "" {
		return loginVO, r.ErrorInvalidParam
	}
	// 检查用户名是否存在
	userAuth := dao.GetOne(model.UserAuth{}, "username", username)
	if userAuth.ID == 0 {
		return loginVO, r.ErrorUserNotExist
	}
	// 检查密码是否正确
	if !utils.Encryptor.BcryptCheck(password, userAuth.Password) {
		return loginVO, r.ErrorPasswordWrong
	}
	// 查询是否封禁
	if userDAO.CheckUserDisabled(userAuth.ID) {
		return loginVO, r.ErrorUserNoRight
	}
	// 获取用户详细信息DTO
	userDetailDTO := convertUserDetailDTO(userAuth, c)

	// 登录信息正确，生成token
	// UUID~ip+浏览器信息+操作系统信息
	uuid := utils.Encryptor.MD5(userDetailDTO.IPAddress + userDetailDTO.Browser + userDetailDTO.OS)
	token, err := utils.GetJWT().GenToken(userAuth.ID, userDetailDTO.RoleLabels[0], uuid)
	if err != nil {
		utils.Logger.Info("登录时生成Token错误", zap.Error(err))
		return loginVO, r.ErrorTokenCreate
	}
	userDetailDTO.Token = token
	// 更新用户验证信息: ip信息+上次登录时间
	dao.Update(&model.UserAuth{
		BaseModel:     model.BaseModel{ID: userAuth.ID},
		IPAddress:     userDetailDTO.IPAddress,
		IPSource:      userDetailDTO.IPSource,
		LastLoginTime: userDetailDTO.LastLoginTime,
	}, "ip_address, ip_source, last_login_time")

	// 保存用户信息到Session和Redis中
	session := sessions.Default(c)
	// session只能储存字符串
	sessionInfoStr := utils.Json.Marshal(dto.SessionInfo{UserDetailDTO: userDetailDTO})
	session.Set(KeyUser+uuid, sessionInfoStr)
	utils.Redis.Set(KeyUser+uuid, sessionInfoStr, time.Duration(config.Cfg.Session.MaxAge)*time.Second)
	_ = session.Save()

	return userDetailDTO.LoginVO, r.OK
}

// 退出登录
func (*User) Logout(c *gin.Context) {
	uuid := utils.GetFromContext[string](c, "uuid")
	session := sessions.Default(c)
	session.Delete(KeyUser + uuid)
	session.Save()
	utils.Redis.Del(KeyUser + uuid)
}

// 注册
func (*User) Register(req req.Register) int {
	if (req.Email == "") || (req.Code == "") || (req.Username == "") || (req.Password == "") {
		return r.ErrorInvalidParam
	}
	// 检测验证码是否正确
	verificationCode := utils.Redis.GetValue(req.Email + "_verification")
	if verificationCode != req.Code {
		return r.ErrorWrongVerificationCode
	}
	userInfo := &model.UserInfo{
		Email:    req.Email,
		Nickname: "用户" + utils.WordsFilter.Filter(req.Username),
		Avatar:   blogInfoService.GetBlogConfig().UserAvatar,
	}
	dao.Create(&userInfo)
	// 设置默认角色
	dao.Create(&model.UserRole{
		UserId: userInfo.ID,
		RoleId: 2,
	})
	dao.Create(&model.UserAuth{
		UserInfoId:    userInfo.ID,
		Username:      req.Username,
		Password:      utils.Encryptor.BcryptHash(req.Password),
		LoginType:     1,
		LastLoginTime: time.Now(),
	})
	return r.OK
}

// 注册时实时检测问题
func (*User) CheckRegisterParam(req req.Register) []int {
	var Code []int
	// 检查用户名是否存在
	if req.Username != "" {
		if exist := utils.CheckUserExistByName(req.Username); exist {
			Code = append(Code, r.ErrorUserNameUsed)
		}
	}
	// 检测邮箱是否存在
	if req.Email != "" {
		if exist := utils.CheckEmailExist(req.Email); exist {
			Code = append(Code, r.ErrorEmailExist)
		}
	}
	if Code != nil {
		return Code
	} else {
		return append(Code, r.OK)
	}
}

// 忘记密码
func (*User) ForgotPassword(req req.ForgotPassword) (int, string) {
	if req.Email == "" || req.Code == "" || req.NewPassword == "" || req.NewUsername == "" {
		return r.ErrorInvalidParam, ""
	}
	// 检查用户名是否存在
	// TODO:排除原用户名
	if exist := utils.CheckUserExistByName(req.NewUsername); exist {
		return r.ErrorUserNameUsed, ""
	}
	UserInfo := dao.GetOne(model.UserInfo{}, "email = ?", req.Email)
	UserAuth := dao.GetOne(model.UserAuth{}, "user_info_id = ?", UserInfo.ID)
	// 验证用户名是否匹配邮箱
	//if req.Email != UserInfo.Email {
	//	return r.ErrorUsernameNotMatchEmail
	//}

	m := map[string]any{
		"username": req.NewUsername,
		"password": utils.Encryptor.BcryptHash(req.NewPassword),
	}
	dao.UpdatesMap(&model.UserAuth{}, m, "user_info_id = ?", UserInfo.ID)
	return r.OK, UserAuth.Username
}

// 忘记密码匹配邮箱
func (*User) FPCheckEmail(req req.FPEmail) int {
	if req.Email == "" || req.Code == "" {
		return r.ErrorInvalidParam
	}
	if !utils.CheckEmailExist(req.Email) {
		return r.ErrorEmailNotExist
	}
	verificationCode := utils.Redis.GetValue(req.Email + "_forgotPassword")
	if verificationCode != req.Code {
		return r.ErrorWrongVerificationCode
	}
	return r.OK
}

// 生成Captcha验证码ID
func (*User) GenerateCaptchaID() resp.CaptchaRespVO {
	captcha.SetCustomStore(&utils.StoreImpl{
		RDB:        utils.Rdb,
		Expiration: time.Second * 1000,
	})
	Captcha := resp.CaptchaRespVO{
		ID: captcha.New(),
	}
	//d := struct {
	//	CaptchaID string
	//}{
	//	captcha.New(),
	//}
	return Captcha
}

// 生成Captcha图
func (*User) GetCaptchaImg(writer bytes.Buffer, id string) {
	err := captcha.WriteImage(&writer, id, 50, 250)
	if err != nil {
		panic(err)
	}
	return
}

// 获取用户信息
func (*User) GetInfo(id int) resp.UserInfoVO {
	var userInfo model.UserInfo
	dao.GetOne(&userInfo, "id", id)
	list := make([]resp.FrontArticleDetailVO, 0)
	data := utils.CopyProperties[resp.UserInfoVO](userInfo)

	ArticleLikeSet := utils.Redis.SMembers(KeyArticleUserLikeSet + strconv.Itoa(id))
	for _, articleID := range ArticleLikeSet {
		aid, _ := strconv.Atoi(articleID)
		list = append(list, articleDAO.GetInfoById(aid))
	}
	data.ArticleLikeSet = list

	list = make([]resp.FrontArticleDetailVO, 0)
	Footstep := utils.Redis.LGet(KeyArticleBrowseHistorySet + strconv.Itoa(id))
	for _, articleID := range Footstep {
		aid, _ := strconv.Atoi(articleID)
		list = append(list, articleDAO.GetInfoById(aid))
	}
	data.Footstep = list
	// data.CommentLikeSet = utils.Redis.SMembers(KeyCommentUserLikeSet + strconv.Itoa(id))
	//data.StarSet,_ = userDAO.GetStarList(data.ID)
	data.Comment, _ = userDAO.GetCommentList(data.ID)
	data.Reply, _ = userDAO.GetReplyList(data.ID)
	return data
}

// 更新用户信息
func (*User) UpdateCurrentUser(current req.UpdateCurrentUser) (code int) {
	user := utils.CopyProperties[model.UserInfo](current)
	dao.Update(&user, "nickname", "avatar")
	return r.OK
}

/* 后台 */

// 查询当前在线用户
func (*User) GetOnlineList(req req.PageQuery) resp.PageResult[[]resp.UserOnline] {
	onlineList := make([]resp.UserOnline, 0)

	keys := utils.Redis.Keys(KeyUser + "*")
	for _, key := range keys {
		var sessionInfo dto.SessionInfo
		utils.Json.Unmarshal(utils.Redis.GetValue(key), &sessionInfo)

		if req.Keyword != "" && !strings.Contains(sessionInfo.Nickname, req.Keyword) {
			continue
		}

		onlineUser := utils.CopyProperties[resp.UserOnline](sessionInfo)
		onlineUser.UserInfoID = sessionInfo.UserInfoID
		onlineList = append(onlineList, onlineUser)
	}
	// 根据上次登录时间排序
	sort.Slice(onlineList, func(i, j int) bool {
		return onlineList[i].LastLoginTime.Unix() > onlineList[j].LastLoginTime.Unix()
	})
	return resp.PageResult[[]resp.UserOnline]{
		Total: int64(len(keys)),
		List:  onlineList,
	}
}

// 转化UserDetailDTO
func convertUserDetailDTO(userAuth model.UserAuth, c *gin.Context) dto.UserDetailDTO {
	// 获取IP信息
	ipAddress := utils.IP.GetIpAddress(c)
	ipSource := utils.IP.GetIpSourceSimpleIdle(ipAddress)
	browser, os := "unknown", "unknown"

	if userAgent := utils.IP.GetUserAgent(c); userAgent != nil {
		browser = userAgent.Name + " " + userAgent.Version.String()
		os = userAgent.OS + " " + userAgent.OSVersion.String()
	}

	// 获取用户详细信息
	userInfo := dao.GetOne(&model.UserInfo{}, "id", userAuth.ID)
	// 获取对应角色,默认user
	roleLabels := roleDAO.GetLabelsByUserInfoID(userInfo.ID)
	if len(roleLabels) == 0 {
		roleLabels = append(roleLabels, "user")
	}
	// 用户点赞Set
	articleLikeSet := utils.Redis.SMembers(KeyArticleUserLikeSet + strconv.Itoa(userInfo.ID))
	commentLikeSet := utils.Redis.SMembers(KeyCommentUserLikeSet + strconv.Itoa(userInfo.ID))

	return dto.UserDetailDTO{
		LoginVO: resp.LoginVO{
			ID:             userAuth.ID,
			UserInfoID:     userInfo.ID,
			Email:          userInfo.Email,
			LoginType:      userAuth.LoginType,
			Username:       userAuth.Username,
			Nickname:       userInfo.Nickname,
			Avatar:         userInfo.Avatar,
			Intro:          userInfo.Intro,
			Website:        userInfo.Website,
			IPAddress:      ipAddress,
			IPSource:       ipSource,
			LastLoginTime:  time.Now(),
			ArticleLikeSet: articleLikeSet,
			CommentLikeSet: commentLikeSet,
		},
		Password:   userAuth.Password,
		IsDisable:  userInfo.IsDisable,
		Browser:    browser,
		OS:         os,
		RoleLabels: roleLabels,
	}
}
