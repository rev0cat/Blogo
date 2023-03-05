package service

import (
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Category struct{}

/* 前台 */

// 获取分类列表
func (*Category) GetFrontList() resp.ListResult[[]resp.CategoryVO] {
	data, total := categoryDAO.GetList(req.PageQuery{})
	return resp.ListResult[[]resp.CategoryVO]{
		Total: total,
		List:  data,
	}
}
