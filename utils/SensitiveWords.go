package utils

import (
	"github.com/syyongx/go-wordsfilter"
)

type _WordsFilter struct{}

var WordsFilter = new(_WordsFilter)

// 敏感词处理
func (*_WordsFilter) Filter(str string) string {
	wf := wordsfilter.New()
	// 不去除空格
	wf.StripSpace = false
	root, _ := wf.GenerateWithFile("sensitive_words.txt")
	newStr := wf.Replace(str, root)
	return newStr
}
