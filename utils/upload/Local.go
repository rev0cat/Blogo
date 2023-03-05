package upload

import (
	"Blogo/config"
	"Blogo/utils"
	"errors"
	"go.uber.org/zap"
	"io"
	"mime/multipart"
	"os"
	"path"
	"strings"
	"time"
)

// 本地文件上传
type Local struct{}

func (*Local) UploadFile(file *multipart.FileHeader) (filePath, fileName string, err error) {
	// 读取文件后缀
	ext := path.Ext(file.Filename)
	// 读取文件名
	name := strings.TrimSuffix(file.Filename, ext)
	// 加密
	name = utils.Encryptor.MD5(name)
	// 拼接新文件名
	filename := name + "_" + time.Now().Format("20060102150405") + ext
	// 创建路径
	mkdirErr := os.Mkdir(config.Cfg.Upload.StorePath, os.ModePerm)
	if mkdirErr != nil && os.IsExist(err) {
		utils.Logger.Error("os.Mkdir()执行失败", zap.Any("err", mkdirErr.Error()))
		return "", "", errors.New("os.Mkdir()执行失败:" + mkdirErr.Error())
	}

	p := config.Cfg.Upload.StorePath + "/" + filename   //   文件存储路径
	filepath := config.Cfg.Upload.Path + "/" + filename // 文件展示路径
	f, openErr := file.Open()                           // 读取文件
	if openErr != nil {
		utils.Logger.Error("file.Open()执行失败", zap.Any("err", openErr.Error()))
		return "", "", errors.New("file.Open()执行失败:" + openErr.Error())
	}
	defer f.Close()

	out, createErr := os.Create(p) // 创建
	if createErr != nil {
		utils.Logger.Error("os.Create()执行失败", zap.Any("err", createErr.Error()))
		return "", "", errors.New("os.Create()执行失败:" + createErr.Error())
	}
	defer out.Close()

	_, copyErr := io.Copy(out, f) // 复制
	if copyErr != nil {
		utils.Logger.Error("io.Copy()执行失败", zap.Any("err", copyErr.Error()))
		return "", "", errors.New("io.Copy()执行失败:" + copyErr.Error())
	}
	os.Chmod(config.Cfg.Upload.StorePath+"/"+filename, 0777)
	return filepath, filename, nil
}

// 从本地删除文件
func (*Local) DeleteFile(key string) error {
	p := config.Cfg.Upload.StorePath + "/" + key
	if strings.Contains(p, config.Cfg.Upload.StorePath) {
		if err := os.Remove(p); err != nil {
			return errors.New("本地文件删除失败:" + err.Error())
		}
	}
	return nil
}
