package dao

import (
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Netdisk struct{}

func (*Netdisk) GetList(req req.PageQuery) ([]resp.NetdiskResource, int64) {
	list := make([]resp.NetdiskResource, 0)
	var total int64

	DB.Table("netdisk").
		Select("id, created_at, updated_at, picture, title, size, url").
		Count(&total).
		Order("id DESC").
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Find(&list)
	return list, total
}
