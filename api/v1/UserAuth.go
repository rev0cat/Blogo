package v1

import (
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/dchest/captcha"
	"github.com/gin-gonic/gin"
	"time"
)

type UserAuth struct{}

// 根据Token获取用户信息
//func (*User) GetInfo(c *gin.Context)  {
//}

// 注册
func (*UserAuth) Register(c *gin.Context) {
	r.SendCode(c, userService.Register(utils.BindForm[req.Register](c)))
}

// 注册实时检测
func (*UserAuth) RegisterCheck(c *gin.Context) {
	r.SendCodes(c, userService.CheckRegisterParam(utils.BindForm[req.Register](c)))
}

// 发送注册验证码
func (*UserAuth) SendRegisterVerificationCode(c *gin.Context) {
	r.SendCode(c, utils.RegisterVerificationCode(utils.BindForm[req.VerificationCode](c)))
}

// 登录
func (*UserAuth) Login(c *gin.Context) {
	loginReq := utils.BindForm[req.Login](c)
	if (loginReq.Username == "") || (loginReq.Password == "") {
		r.SendCode(c, r.ErrorInvalidParam)
	}
	loginVO, code := userService.Login(c, loginReq.Username, loginReq.Password)
	r.SendData(c, code, loginVO)
}

// 退出登录
func (*UserAuth) Logout(c *gin.Context) {
	userService.Logout(c)
	r.SuccessWithoutData(c)
}

//// 获取Captcha验证码ID
//func (*UserAuth) GetCaptchaID(c *gin.Context) {
//	id := userService.GenerateCaptchaID()
//	r.SuccessData(c, id)
//}

//// GenerateImg 生成验证码图片名称
//func (*UserAuth) GenerateImg(c *gin.Context) {
//	c.Writer.Header().Set("Access-Control-Allow-Origin", "*") //允许访问所有域
//	c.Writer.Header().Add("Access-Control-Allow-Headers", "Content-Type")
//	captcha.SetCustomStore(&utils.StoreImpl{
//		RDB:        utils.Rdb,
//		Expiration: time.Second * 1000,
//	})
//	Captcha := userService.GenerateCaptchaID()
//	//bytes, _ := json.Marshal(map[string]interface{}{"code": 0, "msg": "", "count": 0, "data": d.CaptchaId})
//	r.SuccessData(c,Captcha.ID)
//	//c.Writer.Write(bytes)
//}

// 获取Captcha验证码图片
//func (*UserAuth) GetCaptcha(c *gin.Context) {
//	c.Writer.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
//	c.Writer.Header().Set("Pragma", "no-cache")
//	c.Writer.Header().Set("Expires", "0")
//	c.Writer.Header().Set("Access-Control-Allow-Origin", "*") //允许访问所有域
//	c.Writer.Header().Add("Access-Control-Allow-Headers", "Content-Type")
//	//c.Writer.Header().Set("Content-Type", "image/png")
//	//id := c.Param("captchaID")
//	//id = strings.Replace(id, "/", "", 1)
//	var writer bytes.Buffer
//	userService.GenerateCaptchaImgUrl(writer, id)
//	r.ReturnImg(c, id)
//	//c.File(id+".png")
//	return
//}

func (*UserAuth) GenerateCaptcha(c *gin.Context) {
	captcha.SetCustomStore(&utils.StoreImpl{
		RDB:        utils.Rdb,
		Expiration: time.Second * 300,
	})
	d := struct {
		CaptchaId string
	}{
		captcha.New(),
	}
	if d.CaptchaId != "" {
		Captcha := resp.CaptchaRespVO{
			ID:     d.CaptchaId,
			ImgUrl: "/show/" + d.CaptchaId + ".png",
		}
		r.SuccessData(c, Captcha)
	} else {
		r.SendCode(c, r.FAIL)
	}
}

func (*UserAuth) GetCaptchaImg(context *gin.Context) {
	source := context.Param("source")
	utils.Logger.Info("GetCaptchaPng : " + source)
	utils.ServeHTTP(context.Writer, context.Request)
}

// 检查Captcha
func (*UserAuth) VerifyCaptcha(c *gin.Context) {
	captchaId := c.Request.FormValue("captchaID")
	value := c.Request.FormValue("Code")
	if captchaId == "" || value == "" {
		r.SendCode(c, r.ErrorCaptchaWrong)
	} else {
		if captcha.VerifyString(captchaId, value) {
			r.SuccessWithoutData(c)
		} else {
			r.SendCode(c, r.ErrorCaptchaWrong)
		}
	}
}

// 忘记密码
func (*UserAuth) ForgotPassword(c *gin.Context) {
	FPReq := utils.BindForm[req.ForgotPassword](c)
	code, username := userService.ForgotPassword(FPReq)
	r.SendData(c, code, username)
}

// 发送忘记密码验证码
func (*UserAuth) SendForgotPasswordVerificationCode(c *gin.Context) {
	r.SendCode(c, utils.ForgotPasswordVerificationCode(utils.BindForm[req.VerificationCode](c)))
}

// 忘记密码检测验证码
func (*UserAuth) FPCheckCode(c *gin.Context) {
	r.SendCode(c, userService.FPCheckEmail(utils.BindForm[req.FPEmail](c)))
}

// 根据Token获取用户信息
func (*User) GetInfo(c *gin.Context) {
	userInfo := userService.GetInfo(utils.GetFromContext[int](c, "user_info_id"))
	userInfo.IPSource = utils.IP.GetIpSourceSimpleIdle(utils.IP.GetIpAddress(c))
	r.SuccessData(c, userInfo)
}
