package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/resp"
	"Blogo/utils"
	"Blogo/utils/r"
	"strconv"
)

type About struct{}

// 点赞关于页面
func (*About) LikeAbout(userID int) (int, int) {
	// 记录是否已经点赞
	//aboutLikeUserKey:=KeyAboutLikeSet+strconv.Itoa(userID)
	//已经点赞过,再点取消点赞
	//if utils.Redis.SIsMember(KeyAboutLikeSet, strconv.Itoa(userID)) {
	//	utils.Redis.SRem(KeyAboutLikeSet, strconv.Itoa(userID))
	//	utils.Redis.IncrBy(KeyAboutLikeCount, -1)
	//	return r.OK, false
	//} else {
	// 获取点赞次数
	likeCountStr := utils.Redis.GetValue(KeyAboutLikeCount)
	likeCount, _ := strconv.Atoi(likeCountStr)
	if utils.Redis.SIsMember(KeyAboutLikeSet, strconv.Itoa(userID)) {

		return r.FAIL, likeCount
	}
	utils.Redis.SAdd(KeyAboutLikeSet, strconv.Itoa(userID))
	utils.Redis.Incr(KeyAboutLikeCount)
	return r.OK, likeCount + 1
	//}
}

// 获取关于页面信息
func (*About) GetAbout() resp.AboutVO {
	var aboutVO resp.AboutVO
	aboutVOStr := utils.Redis.GetValue(KeyAbout)
	if aboutVOStr == "" {
		aboutVO = aboutDAO.GetAbout()
		// 查格言
		dictum := dao.GetOne(model.Dictum{}, "id = ?", aboutVO.DictumID)
		aboutVO.Dictum.Content = dictum.Content
		aboutVO.Dictum.Author = dictum.Author
		// 查询经历
		aboutVO.Experience = dao.List([]model.Experience{}, "*", "", "")
		// 缓存
		utils.Redis.Set(KeyAbout, utils.Json.Marshal(aboutVO), 0)
	} else {
		utils.Json.Unmarshal(aboutVOStr, &aboutVO)
	}
	aboutVO.LikeCount = 0
	// 查点赞数量
	aboutVO.LikeCount = utils.Redis.GetInt(KeyAboutLikeCount)
	// 查是否点赞

	return aboutVO
}
