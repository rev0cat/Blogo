package utils

import (
	"log"
	"net"
	"regexp"
	"strings"
)

type _Regexp struct{}

var (
	Regexp = new(_Regexp)
	reg    *regexp.Regexp
)

func InitRegexp() *regexp.Regexp {
	pattern := "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
	// 解析正则表达式
	reg = regexp.MustCompile(pattern)
	if reg == nil {
		Logger.Warn("正则表达式解析失败")
		log.Fatal("正则表达式解析失败!")
	}
	log.Println("正则表达式解析成功!")
	return reg
}

// 正则表达式验证邮箱格式
func (*_Regexp) CheckEmailForm(email string) bool {
	if !reg.MatchString(email) {
		return false
	}
	parts := strings.Split(email, "@")
	mx, err := net.LookupMX(parts[1])
	if err != nil || len(mx) == 0 {
		return false
	}
	return true
}
