package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/utils"
)

type Carousel struct{}

func (*Carousel) GetCarousel() []string {
	list := make([]string, 0)
	list = utils.Redis.SMembers(KeyCarousel)
	if len(list) == 0 {
		dataList := dao.List([]model.Carousel{}, "*", "", "")
		for _, data := range dataList {
			list = append(list, data.Url)
		}
		utils.Redis.SAdd(KeyCarousel, list)
	}
	return list
}
