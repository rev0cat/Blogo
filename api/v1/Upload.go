package v1

import (
	"Blogo/utils"
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Upload struct{}

func (*Upload) UploadFile(c *gin.Context) {
	_, fileHeader, err := c.Request.FormFile("file")
	// 处理错误
	if err != nil {
		utils.Logger.Error(r.GetMsg(r.ErrorFileReceive), zap.Error(err))
		r.SendCode(c, r.ErrorFileReceive)
		return
	}
	// 上传文件
	url, code := fileService.Upload(fileHeader)
	r.SendData(c, code, url)
}
