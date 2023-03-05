package utils

import (
	"Blogo/config"
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/utils/r"
	"bytes"
	"context"
	"fmt"
	"github.com/dchest/captcha"
	"github.com/go-redis/redis/v9"
	"gopkg.in/gomail.v2"
	"math/rand"
	"net/http"
	"path"
	"strings"
	"time"
)

const VerificationCodeErrPrefix = "utils/VerificationCode.go -> "

type _VerificationCode struct{}

// 注册验证码
func RegisterVerificationCode(req req.VerificationCode) int {
	if req.Email == "" {
		return r.ErrorInvalidParam
	}
	// 验证邮箱格式
	if !Regexp.CheckEmailForm(req.Email) {
		return r.ErrorEmailFormWrong
	}
	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	code := fmt.Sprintf("%06v", rnd.Int31n(1000000))
	Redis.Set(req.Email+"_verification", code, 3*time.Minute)
	SendVerificationCode(req.Email, code, "注册")
	return r.OK
}

// 找回密码验证码
func ForgotPasswordVerificationCode(req req.VerificationCode) int {
	if req.Email == "" {
		return r.ErrorInvalidParam
	}
	// 验证邮箱格式
	if !Regexp.CheckEmailForm(req.Email) {
		return r.ErrorEmailFormWrong
	}
	if !CheckEmailExist(req.Email) {
		return r.ErrorEmailNotExist
	}
	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	code := fmt.Sprintf("%06v", rnd.Int31n(1000000))
	Redis.Set(req.Email+"_forgotPassword", code, 3*time.Minute)
	SendVerificationCode(req.Email, code, "找回密码")
	return r.OK
}

func SendVerificationCode(to, code, method string) int {
	//msg := "您的" + method + "验证码是" + code + ",三分钟内有效！"
	m := gomail.NewMessage()
	body := "[Come to Witness My World】验证码:" + code + ",三分钟内有效。如非本人操作请无视本条邮件。验证码提供给他人可能导致账号被盗，请勿泄露，谨防被骗。"
	m.SetHeader("From", config.Cfg.Email.Username)

	m.SetHeader("To", to)
	m.SetHeader("Subject", "您的"+method+"验证码")
	//m.SetBody("text/html",msg)
	//m.SetBody("text/html", body)
	m.SetBody("text/plain", body)

	d := gomail.NewDialer(
		config.Cfg.Email.Host,
		config.Cfg.Email.Port,
		config.Cfg.Email.Username,
		config.Cfg.Email.Password,
	)

	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
	return r.OK
}

func CheckUserExistByName(username string) bool {
	existUser := dao.GetOne(model.UserAuth{}, "username = ?", username)
	return existUser.ID != 0
}

func CheckEmailExist(email string) bool {
	existUser := dao.GetOne(model.UserInfo{}, "email = ?", email)
	return existUser.ID != 0
}

// Captcha Store
type StoreImpl struct {
	RDB        *redis.Client
	Expiration time.Duration
}

func (impl *StoreImpl) Set(id string, digits []byte) {
	impl.RDB.Set(context.Background(), "captcha:"+id, string(digits), impl.Expiration)
}

func (impl *StoreImpl) Get(id string, clear bool) (digits []byte) {
	bytes, _ := impl.RDB.Get(context.Background(), "captcha:"+id).Bytes()
	return bytes
}

func Serve(w http.ResponseWriter, r *http.Request, id, ext, lang string, download bool, width, height int) error {
	w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	w.Header().Set("Pragma", "no-cache")
	w.Header().Set("Expires", "0")

	var content bytes.Buffer
	switch ext {
	case ".png":
		w.Header().Set("Content-Type", "image/png")
		captcha.WriteImage(&content, id, width, height)
	case ".wav":
		w.Header().Set("Content-Type", "audio/x-wav")
		captcha.WriteAudio(&content, id, lang)
	default:
		return captcha.ErrNotFound
	}

	if download {
		w.Header().Set("Content-Type", "application/octet-stream")
	}
	http.ServeContent(w, r, id+ext, time.Time{}, bytes.NewReader(content.Bytes()))
	return nil
}

func ServeHTTP(w http.ResponseWriter, r *http.Request) {
	dir, file := path.Split(r.URL.Path)
	ext := path.Ext(file)
	id := file[:len(file)-len(ext)]
	fmt.Println("file : " + file)
	fmt.Println("ext : " + ext)
	fmt.Println("id : " + id)
	if ext == "" || id == "" {
		http.NotFound(w, r)
		return
	}
	fmt.Println("reload : " + r.FormValue("reload"))
	if r.FormValue("reload") != "" {
		captcha.Reload(id)
	}
	lang := strings.ToLower(r.FormValue("lang"))
	download := path.Base(dir) == "download"
	if Serve(w, r, id, ext, lang, download, captcha.StdWidth, captcha.StdHeight) == captcha.ErrNotFound {
		http.NotFound(w, r)
	}
}
