package utils

import (
	"bufio"
	"go.uber.org/zap"
	"io"
	"mime/multipart"
	"os"
)

var File fileUtils

type fileUtils struct{}

// 将文件写入到本地，已有同名文件则覆盖
func (*fileUtils) WriteFile(name, path, content string) {
	// 指定模式打开文件：读写/创建
	file, err := os.OpenFile(path+name, os.O_RDWR|os.O_CREATE, 0666)
	if err != nil {
		Logger.Error("文件写入目标地址错误:", zap.Error(err))
		return
	}
	defer func(file *os.File) {
		_ = file.Close()
	}(file)
	writer := bufio.NewWriter(file)      // 文件写入对象
	_, err = writer.WriteString(content) // 内容写入缓存
	_ = writer.Flush()                   // 缓存写入文件
	if err != nil {
		Logger.Error("文件写入失败:", zap.Error(err))
	}
}

// 从fileHeader中读取内容
func (*fileUtils) ReadFromFileHeader(file *multipart.FileHeader) string {
	open, err := file.Open()
	if err != nil {
		Logger.Error("文件读取目标地址错误", zap.Error(err))
	}
	defer open.Close()
	all, err := io.ReadAll(open)
	if err != nil {
		Logger.Error("文件读取失败", zap.Error(err))
		return ""
	}
	return string(all)
}
