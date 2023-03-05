package utils

import (
	"github.com/go-playground/locales/zh_Hans_CN"
	unTrans "github.com/go-playground/universal-translator"
	"github.com/go-playground/validator/v10"
	zhTrans "github.com/go-playground/validator/v10/translations/zh"
	"reflect"
)

var Validator = new(ValidateUtil)

type ValidateUtil struct{}

var (
	uni      *unTrans.UniversalTranslator
	validate *validator.Validate
)

// ValidateTransInit 数据验证翻译器
func (*ValidateUtil) ValidateTransInit(validate *validator.Validate) unTrans.Translator {
	// 万能翻译器，保存所有的语言环境和翻译数据
	uni = unTrans.New(zh_Hans_CN.New())
	// 翻译器
	trans, _ := uni.GetTranslator("zh_Hans_CN")
	// 验证码注册翻译器
	zhTrans.RegisterDefaultTranslations(validate, trans)

	// 读取Tag中的label标签
	validate.RegisterTagNameFunc(func(field reflect.StructField) string {
		return field.Tag.Get("label")
	})
	return trans
}

// 返回验证错误信息, 为 "" 则无错误
func (v *ValidateUtil) Validate(data any) string {
	// 验证对象
	validate = validator.New()
	// 翻译器
	trans := v.ValidateTransInit(validate)

	err := validate.Struct(data)
	if err != nil {
		for _, e := range err.(validator.ValidationErrors) {
			return e.Translate(trans)
		}
	}

	return ""
}
