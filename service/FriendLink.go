package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
)

type FriendLink struct{}

/* 前台 */
// 获取友链
func (*FriendLink) GetFrontList() (data resp.FriendLinkVO) {
	blogConfig := blogInfoService.GetBlogConfig()
	data = utils.CopyProperties[resp.FriendLinkVO](blogConfig)
	data.ExampleName = blogConfig.WebsiteName
	data.ExampleAvatar = blogConfig.WebsiteAvatar
	data.FriendLinkList = friendLinkDAO.GetList()
	data.Requirement = friendLinkDAO.GetRequirements()
	return
}

// 申请友链
func (*FriendLink) ApplyFriendLink(req req.ApplyFriendLink) int {
	if req.Name == "" || req.Address == "" || req.Avatar == "" || req.Intro == "" {
		return r.ErrorInvalidParam
	}
	// 查询是否存在
	existByUrl := dao.GetOne(model.FriendLink{}, "address = ?", req.Address)
	if !existByUrl.IsEmpty() {
		return r.ErrorFriendLinkExist
	}
	friendLink := utils.CopyProperties[model.FriendLink](req)
	dao.Create(&friendLink)
	return r.OK
}
