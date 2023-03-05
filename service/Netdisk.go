package service

import (
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Netdisk struct{}

func (*Netdisk) GetList(req req.PageQuery) []resp.NetdiskResource {
	list, _ := netdiskDAO.GetList(req)
	return list
}
