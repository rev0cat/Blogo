package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
	"strconv"
)

type Message struct{}

/* 前台接口 */

// 获取留言列表
func (*Message) GetList(req req.GetMessages) resp.MessageListVO {
	list := make([]resp.FrontMessageVO, 0)
	var total int64
	var response resp.MessageListVO
	list, total = messageDAO.GetList(req)
	response.MessageList = list
	response.Total = total
	for i, message := range response.MessageList {
		response.MessageList[i].LikeCount = utils.Redis.HGet(KeyMessageLikeCount,
			strconv.Itoa(message.ID))
	}
	return response
}

// 点赞留言
func (*Message) LikeMessage(uid, messageID int) (code int) {
	// 判断是否点赞
	messageLikeUserKey := KeyMessageUserLikeSet + strconv.Itoa(uid)
	// 已经点赞，再点击取消
	if utils.Redis.SIsMember(messageLikeUserKey, messageID) {
		utils.Redis.SRem(messageLikeUserKey, messageID)
		utils.Redis.HIncrBy(KeyMessageLikeCount, strconv.Itoa(messageID), -1)
	} else {
		utils.Redis.SAdd(messageLikeUserKey, messageID)
		utils.Redis.HIncrBy(KeyMessageLikeCount, strconv.Itoa(messageID), 1)
	}
	return r.OK
}

// 查询已点赞留言
func (*Message) CheckMessageLike(uid int) []bool {
	messageLikeUserKey := KeyMessageUserLikeSet + strconv.Itoa(uid)
	messageList, count := messageDAO.GetList(req.GetMessages{})
	res := make([]bool, count)
	for i, message := range messageList {
		if utils.Redis.SIsMember(messageLikeUserKey, message.ID) {
			res[i] = true
		} else {
			res[i] = false
		}
	}
	return res
}

// 添加留言
func (*Message) AddMessage(uid int, req req.AddMessage) int {
	if req.Content == "" {
		return r.ErrorInvalidParam
	}
	// if userDAO.CheckUserDisabled(uid) {
	// 	return r.ErrorUserNoRight
	// }
	message := utils.CopyProperties[model.Message](req)
	nickname, avatar := userDAO.GetNicknameAvatar(uid)
	message.Nickname = nickname
	message.Avatar = avatar
	// 屏蔽词
	message.Content = utils.WordsFilter.Filter(message.Content)
	dao.Create(&message)
	return r.OK
}
