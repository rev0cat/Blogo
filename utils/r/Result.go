package r

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Response struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
	Data    any    `json:"data"`
}

type MultiCodeResponse struct {
	Codes    []int    `json:"codes"`
	Messages []string `json:"messages"`
	Data     any      `json:"data"`
}

// 返回 JSON 数据
func ReturnJson(c *gin.Context, httpCode, code int, msg string, data any) {
	// c.Header("", "") // 根据需要在头部添加其他信息
	c.JSON(httpCode, Response{
		Code:    code,
		Message: msg,
		Data:    data,
	})
}

// 返回多个代码的JSON数据
func ReturnMultiCodeJson(c *gin.Context, httpCode int, codes []int, msg []string, data any) {
	// c.Header("", "") // 根据需要在头部添加其他信息
	c.JSON(httpCode, MultiCodeResponse{
		Codes:    codes,
		Messages: msg,
		Data:     data,
	})
}

// 返回多个Data的JSON数据
func ReturnMultiDataJson(c *gin.Context, httpCode, code int, msg string, data ...any) {
	// c.Header("", "") // 根据需要在头部添加其他信息
	c.JSON(httpCode, Response{
		Code:    code,
		Message: msg,
		Data:    data,
	})
}

func ReturnImg(c *gin.Context, name string) {
	//c.Writer.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	//c.Writer.Header().Set("Pragma", "no-cache")
	//c.Writer.Header().Set("Expires", "0")
	//c.Writer.Header().Set("Content-Type", "image/png")
	//var writer bytes.Buffer
	//http.ServeContent(c.Writer, c.Request, name+".png", time.Time{}, bytes.NewReader(writer.Bytes()))
	c.File(name + ".png")
}

// 语法糖函数封装

// 自定义 httpCode, code, data
func Send(c *gin.Context, httpCode, ErrCode int, data any) {
	ReturnJson(c, httpCode, ErrCode, GetMsg(ErrCode), data)
}

func SendCodes(c *gin.Context, ErrCode []int) {
	ReturnMultiCodeJson(c, http.StatusOK, ErrCode, GetMsgs(ErrCode), nil)
}

func SendCode(c *gin.Context, ErrCode int) {
	Send(c, http.StatusOK, ErrCode, nil)
}

func SendData(c *gin.Context, ErrCode int, data any) {
	Send(c, http.StatusOK, ErrCode, data)
}

// 有Data
func SuccessData(c *gin.Context, data any) {
	Send(c, http.StatusOK, OK, data)
}

// 有多个Data
func SuccessMultiData(c *gin.Context, data ...any) {
	ReturnMultiDataJson(c, http.StatusOK, OK, GetMsg(OK), data)
}

// 无Data
func SuccessWithoutData(c *gin.Context) {
	Send(c, http.StatusOK, OK, nil)
}
