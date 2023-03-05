package utils

import (
	"Blogo/config"
	"errors"
	"github.com/golang-jwt/jwt/v4"
	"time"
)

// Token相关Error
var (
	ErrorTokenExpired   = errors.New("Token已过期，请重新登录")
	ErrorTokenNotValid  = errors.New("Token无效，请重新登录")
	ErrorTokenMalformed = errors.New("Token不正确，请重新登录")
	ErrorTokenInvalid   = errors.New("这不是一个Token，请重新登录")
)

type MyClaims struct {
	UserId int    `json:"userId"`
	Role   string `json:"role"`
	UUID   string `json:"uuid"`
	jwt.RegisteredClaims
}

type MyJWT struct {
	Secret []byte
}

// JWT工具类
func GetJWT() *MyJWT {
	return &MyJWT{[]byte(config.Cfg.JWT.Secret)}
}

// 生成JWT
func (j *MyJWT) GenToken(userID int, role string, uuid string) (string, error) {
	claims := MyClaims{
		UserId: userID,
		Role:   role,
		UUID:   uuid,
		RegisteredClaims: jwt.RegisteredClaims{
			Issuer: config.Cfg.JWT.Issuer,
			ExpiresAt: jwt.NewNumericDate(time.Now().
				Add(time.Duration(config.Cfg.JWT.Expire) * time.Hour)), // x小时后过期
		},
	}
	// 使用指定的签名方法创建签名对象
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	// 使用指定的 secret 签名并获得完整编码后的字符串 token
	return token.SignedString(j.Secret)
}

// JWT解析
func (j *MyJWT) ParseToken(tokenString string) (*MyClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &MyClaims{}, func(t *jwt.Token) (interface{}, error) {
		return j.Secret, nil
	})

	if err != nil {
		if vError, ok := err.(*jwt.ValidationError); ok {
			if vError.Errors&jwt.ValidationErrorMalformed != 0 {
				return nil, ErrorTokenMalformed
			} else if vError.Errors&jwt.ValidationErrorExpired != 0 {
				return nil, ErrorTokenExpired
			} else if vError.Errors&jwt.ValidationErrorNotValidYet != 0 {
				return nil, ErrorTokenNotValid
			} else {
				return nil, ErrorTokenInvalid
			}
		}
	}

	// 校验token
	if claims, ok := token.Claims.(*MyClaims); ok && token.Valid {
		return claims, nil
	}
	return nil, ErrorTokenInvalid
}
