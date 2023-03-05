package utils

import (
	"encoding/json"

	"go.uber.org/zap"
)

const JsonUtilErrorPrefix = "utils/Json.go -> "

var Json = new(_Json)

type _Json struct{}

// data -> JsonStr
func (*_Json) Marshal(v any) string {
	data, err := json.Marshal(v)
	if err != nil {
		Logger.Error(JsonUtilErrorPrefix+"Marshal:", zap.Error(err))
		panic(err)
	}
	return string(data)
}

// JsonStr -> data
func (*_Json) Unmarshal(data string, v any) {
	err := json.Unmarshal([]byte(data), &v)
	if err != nil {
		Logger.Error(JsonUtilErrorPrefix+"Unmarshal:", zap.Error(err))
		panic(err)
	}
}
