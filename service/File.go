package service

import (
	"Blogo/utils/r"
	"Blogo/utils/upload"
	"mime/multipart"
)

type File struct{}

// 上传
func (*File) Upload(header *multipart.FileHeader) (url string, code int) {
	oss := upload.NewOSS()
	filePath, _, err := oss.UploadFile(header)
	if err != nil {
		return "", r.ErrorFileUpload
	}
	return filePath, r.OK
}
