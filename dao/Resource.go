package dao

import "Blogo/model"

type Resource struct{}

// 根据资源ID列表获取资源列表
func (*Resource) GetListByIDs(ids []int) (list []model.Resource) {
	return List([]model.Resource{}, "url, request_method", "", "id in ?", ids)
}

// 根据关键字获取资源列表(非树形)
func (*Resource) GetListByKeyword(keyword string) (list []model.Resource) {
	if keyword != "" {
		list = List([]model.Resource{}, "*", "", "name LIKE ?", "%"+keyword+"%")
	} else {
		list = List([]model.Resource{}, "*", "", "")
	}
	return
}
