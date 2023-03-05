package utils

import (
	"crypto/md5"
	"encoding/base64"
	"encoding/hex"
	"golang.org/x/crypto/bcrypt"
	"golang.org/x/crypto/scrypt"
	"log"
)

type _encryptor struct{}

var Encryptor = new(_encryptor)

// 使用scrypt对密码加密生成哈希值
func (*_encryptor) ScryptHash(password string) string {
	const KeyLen = 10
	salt := []byte{11, 45, 14, 191, 9, 8, 10}

	hashPwd, err := scrypt.Key([]byte(password), salt, 1<<15, 8, 1, KeyLen)
	if err != nil {
		log.Fatal("加密失败:", err)
	}
	return base64.StdEncoding.EncodeToString(hashPwd)
}

// scrypt对比明文密码和数据库的哈希值
func (e *_encryptor) ScryptCheck(password, hash string) bool {
	return e.ScryptHash(password) == hash
}

// bcrypt对密码加密生成哈希值
func (*_encryptor) BcryptHash(password string) string {
	bytes, _ := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes)
}

// bcrypt对比明文密码和数据库的哈希值
func (*_encryptor) BcryptCheck(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// MD5加密
func (*_encryptor) MD5(str string, b ...byte) string {
	h := md5.New()
	h.Write([]byte(str))
	return hex.EncodeToString(h.Sum(b))
}
