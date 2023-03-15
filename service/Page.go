package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/utils"
	"Blogo/utils/r"
)

type Page struct{}

func (*Page) GetList() []model.Page {
	list := make([]model.Page, 0)
	// 从Redis取数据
	listStr, err := utils.Redis.GetResult(KeyPage)
	if listStr == "" || err != nil {
		list = dao.List([]model.Page{}, "id, name, label, cover, created_at, updated_at", "", "")
		utils.Redis.Set(KeyPage, utils.Json.Marshal(list), 0)
	} else {
		utils.Json.Unmarshal(listStr, &list)
	}
	return list
}

func (*Page) SaveOrUpdate(req req.AddOrEditPage) (code int) {
	if req.Cover == "" || req.Name == "" || req.Label == "" {
		return r.ErrorInvalidParam
	}
	// 检查是否存在
	exist := dao.GetOne(model.Page{}, "name", req.Name)
	if exist.ID != 0 && exist.ID != req.ID {
		return r.ErrorPageNameExist
	}

	page := utils.CopyProperties[model.Page](req)
	if page.ID == 0 {
		dao.Update(&page)
	} else {
		dao.Create(&page)
	}
	utils.Redis.Del(KeyPage)
	return r.OK
}

func (*Page) Delete(ids []int) (code int) {
	dao.Delete(model.Page{}, "id IN ?", ids)
	utils.Redis.Del(KeyPage)
	return r.OK
}

func (*Page) GetPage() []string {
	// 从Redis取数据
	var pageList []model.Page
	list := make([]string, 0)
	list = utils.Redis.SMembers(KeyPage)
	if len(list) == 0 {
		pageList = dao.List([]model.Page{}, "*", "", "")
		for i := range pageList {
			utils.Redis.ZAdd(KeyPage, pageList[i].Cover, float64(len(pageList)-i))
			list = append(list, pageList[i].Cover)
		}
	}
	return list
}
