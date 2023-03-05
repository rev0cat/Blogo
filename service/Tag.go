package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
)

type Tag struct{}

/* 前台 */

// 查询标签列表(前台)
func (*Tag) GetFrontList() resp.ListResult[[]resp.TagVO] {
	data, total := tagDAO.GetList(req.PageQuery{})
	return resp.ListResult[[]resp.TagVO]{
		Total: total,
		List:  data,
	}
}

/* 后台 */

// 新增/修改
func (*Tag) Update(req req.AddOrUpdateTag) int {
	// 是否存在
	exist := dao.GetOne(model.Tag{}, "name", req.Name)
	if !exist.IsEmpty() && exist.ID != req.ID {
		return r.ErrorTagExist
	}
	tag := utils.CopyProperties[model.Tag](req)

	if req.ID != 0 {
		dao.Update(&tag, "name")
	} else {
		dao.Create(&tag)
	}
	return r.OK
}
