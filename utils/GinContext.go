package utils

import (
	"Blogo/model/req"
	"Blogo/utils/r"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

// 参数合法性校验
func Validate(c *gin.Context, data any) {
	validMsg := Validator.Validate(data)
	if validMsg != "" {
		r.ReturnJson(c, http.StatusOK, r.ErrorInvalidParam, validMsg, nil)
		panic(nil)
	}
}

// JSON绑定
func BindJSON[T any](c *gin.Context) (data T) {
	if error := c.ShouldBindJSON(&data); error != nil {
		// JSON绑定错误
		Logger.Error("BindJSON", zap.Error(error))
		panic(r.ErrorRequestParam)
	}
	return
}

// JSON绑定验证、合法性校验
func BindValidJSON[T any](c *gin.Context) (data T) {
	// JSON绑定
	if err := c.ShouldBindJSON(&data); err != nil {
		// JSON绑定错误
		Logger.Error("BindValidJSON:", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	// 参数合法性校验
	Validate(c, data)
	return data
}

// Param绑定
func BindQuery[T any](c *gin.Context) (data T) {
	if err := c.ShouldBindQuery(&data); err != nil {
		Logger.Error("BindQuery", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	return
}

// 检查分页参数
func CheckQueryPage(pageSize, pageNum *int) {
	// 每页最少10个，最多100个，至少有一页
	switch {
	case *pageSize >= 100:
		*pageSize = 100
	case *pageSize < 0:
		*pageSize = 10
	}
	if *pageNum <= 0 {
		*pageNum = 1
	}
}

// Param分页绑定(处理PageSize和PageParam)
func BindPageQuery(c *gin.Context) (data req.PageQuery) {
	if err := c.ShouldBindQuery(&data); err != nil {
		Logger.Error("BindPageQuery", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	// 检查分页参数
	CheckQueryPage(&data.PageSize, &data.PageNum)
	return
}

// Param绑定验证 + 合法性校验
func BindValidQuery[T any](c *gin.Context) (data T) {
	// Query绑定
	if err := c.ShouldBindQuery(&data); err != nil {
		Logger.Error("BindValidQuery", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	// 参数合法性校验
	Validate(c, &data)
	return data
}

// 表单绑定验证 + 合法性校验
func BindForm[T any](c *gin.Context) (data T) {
	// 绑定
	if err := c.ShouldBind(&data); err != nil {
		Logger.Error("BindForm", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	// 参数合法性校验
	//Validate(c, &data)
	return data
}

// 从ginContext取值，这个值是JWT Middleware解析Token后设置的
// 若该值不存在，则Token有问题
func GetFromContext[T any](c *gin.Context, key string) T {
	val, exist := c.Get(key)
	if !exist {
		panic(r.ErrorTokenRuntime)
	}
	return val.(T)
}

// 从gin.Context获取int类型的Param参数
func GetIntParam(c *gin.Context, key string) int {
	val, err := strconv.Atoi(c.Param(key))
	if err != nil {
		Logger.Error("GetIntParam", zap.Error(err))
		panic(r.ErrorRequestParam)
	}
	return val
}
