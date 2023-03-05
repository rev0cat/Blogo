package dao

import "Blogo/model"

type Photo struct{}

// 获取照片列表
func (*Photo) GetList() ([]string, int64) {
	list := make([]string, 0)
	var total int64

	DB.Model(model.Photo{}).
		Select("url").
		Count(&total).
		Find(&list)
	return list, total
}
