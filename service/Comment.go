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

type Comment struct{}

/* 前台 */

// 前台文章评论列表
func (*Comment) GetFrontList(req req.GetFrontComments) ([]resp.FrontCommentVO, int64) {
	// 查询评论列表
	commentList, total := commentDAO.GetFrontList(req)
	// 统计评论ID列表
	commentIDs := make([]int, 0)
	for _, comment := range commentList {
		commentIDs = append(commentIDs, comment.ID)
	}
	// 评论ID对应点赞数
	likeCountMap := utils.Redis.HGetAll(KeyCommentLikeCount)
	// 获取回复列表
	replyList := commentDAO.GetReplyList(commentIDs)
	replyMap := make(map[int][]resp.ReplyVO)
	for i, reply := range replyList {
		replyList[i].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(reply.ID)])
		reply.ReplyVOList, reply.ReplyCount = GetFloorReplyByID(reply.ID)
		replyMap[reply.ParentId] = append(replyMap[reply.ParentId], reply)
	}
	// 获取评论回复数量
	replyCountList := commentDAO.GetReplyCountListByCommentID(commentIDs)
	replyCountMap := make(map[int]int)
	for _, reply := range replyCountList {
		replyCountMap[reply.CommentID] = reply.ReplyCount
	}
	for i, comment := range commentList {
		commentList[i].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(comment.ID)])
		commentList[i].ReplyVOList = replyMap[comment.ID]
		commentList[i].ReplyCount = replyCountMap[comment.ID]
		// 获取点赞数量
		for j, reply := range commentList[i].ReplyVOList {
			//if len(replyMap[reply.ParentId]) < 3 {
			commentList[i].ReplyVOList[j].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(reply.ID)])
			//}
		}
	}
	return commentList, total
}

// 点赞
func (*Comment) LikeComment(uid, commentID int) int {
	// 查询是否已经点过赞
	LikeUserKey := KeyCommentUserLikeSet + strconv.Itoa(uid)
	// 已经点赞过，取消点赞
	if utils.Redis.SIsMember(LikeUserKey, commentID) {
		utils.Redis.SRem(LikeUserKey, commentID)
		utils.Redis.HIncrBy(KeyCommentUserLikeSet, strconv.Itoa(commentID), -1)
	} else {
		utils.Redis.SAdd(LikeUserKey, commentID)
		utils.Redis.HIncrBy(KeyCommentLikeCount, strconv.Itoa(commentID), 1)
	}
	return r.OK
}

// 查询点赞列表
func (*Comment) CheckCommentLike(uid int) []string {
	LikeUserKey := KeyCommentUserLikeSet + strconv.Itoa(uid)
	res := utils.Redis.SMembers(LikeUserKey)
	return res
}

// 添加评论
func (*Comment) Comment(uid int, req req.SaveComment) int {
	if req.Content == "" || req.TopicID == 0 {
		return r.ErrorCommentNotExist
	}
	comment := utils.CopyProperties[model.Comment](req)
	// if userDAO.CheckUserDisabled(uid){
	// 	return r.ErrorUserNoRight
	// }
	comment.UserID = uid
	// 查询是否审核
	isCommentReview := blogInfoService.GetBlogConfig().IsCommentReview
	comment.IsReview = isCommentReview
	// 查询楼主ID
	if comment.ParentID != 0 {
		comment.ReplyUserID = dao.GetOne(model.Comment{}, "id = ?", comment.ParentID).UserID
	}
	// 屏蔽词
	comment.Content = utils.WordsFilter.Filter(comment.Content)
	dao.Create(&comment)
	return r.OK
}

// 根据评论ID获取回复列表
func (*Comment) GetReplyListByCommentID(id int, req req.PageQuery) []resp.ReplyVO {
	replyList := commentDAO.GetReplyListByCommentID(id, req)
	likeCountMap := utils.Redis.HGetAll(KeyCommentLikeCount)
	for i, reply := range replyList {
		replyList[i].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(reply.ID)])
		replyList[i].ReplyVOList, replyList[i].ReplyCount = GetFloorReplyByID(reply.ID)
	}
	return replyList
}

// 根据评论ID获取楼中楼
func GetFloorReplyByID(id int) ([]resp.ReplyVO, int64) {
	replyList, replyCount := commentDAO.GetFloorReplyByID(id)
	likeCountMap := utils.Redis.HGetAll(KeyCommentLikeCount)
	for i, reply := range replyList {
		replyList[i].LikeCount, _ = strconv.Atoi(likeCountMap[strconv.Itoa(reply.ID)])
	}
	return replyList, replyCount
}
