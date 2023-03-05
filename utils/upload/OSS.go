package upload

import (
	"Blogo/config"
	"mime/multipart"
)

// OSS对象存储接口
type OSS interface {
	UploadFile(file *multipart.FileHeader) (string, string, error)
	DeleteFile(key string) error
}

// 判断文件上传实例
func NewOSS() OSS {
	switch config.Cfg.Upload.OssType {
	case "local":
		return &Local{}
	//case "qiniu":
	//	return &Qiniu{}
	default:
		return &Local{}
	}
}
