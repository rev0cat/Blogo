package utils

import (
	"math/rand"
	"time"
)

var Random = _Random{}

type _Random struct {
}

func (*_Random) GetRandomWithAll(min, max int) int64 {
	rand.Seed(time.Now().UnixNano())
	return int64(rand.Intn(max-min+1) + min)
}
