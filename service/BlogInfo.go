package service

import (
	"Blogo/dao"
	"Blogo/model"
	"Blogo/model/resp"
	"Blogo/utils"
)

type BlogInfo struct{}

/* 后台接口 */

// 获取博客设置
func (*BlogInfo) GetBlogConfig() (respVO model.BlogConfigDetail) {
	// 尝试从 Redis 中取值
	blogConfig := utils.Redis.GetValue(KeyBlogConfig)
	// Redis 中没有值, 再查数据库, 查到后设置到 Redis 中
	if blogConfig == "" {
		blogConfig = dao.GetOne(model.BlogConfig{}, "id", 1).Config
		utils.Redis.Set(KeyBlogConfig, blogConfig, 0)
	}
	// 反序列化字符串为 golang 对象
	utils.Json.Unmarshal(blogConfig, &respVO)
	return respVO
}

/* 前台接口 */
func (b *BlogInfo) GetFrontHomeInfo() resp.FrontBlogHomeVO {
	articleCount := dao.Count(model.Article{}, "status = ? AND is_delete = ?", 1, 0)
	userCount := dao.Count(model.UserInfo{}, "")
	messageCount := dao.Count(model.Message{}, "")
	categoryCount := dao.Count(model.Category{}, "")
	tagCount := dao.Count(model.Tag{}, "")
	banners := dao.List([]model.Banner{}, "id, content", "", "")
	blogConfigVO := b.GetBlogConfig()
	viewCount := utils.Redis.GetInt(KeyViewCount)
	sentenceCount := dao.Count(model.Sentence{}, "")
	sentenceID := utils.Random.GetRandomWithAll(1, int(sentenceCount))
	sentence := dao.GetOne(model.Sentence{}, "id = ?", sentenceID)
	return resp.FrontBlogHomeVO{
		ArticleCount:  articleCount,
		UserCount:     userCount,
		MessageCount:  messageCount,
		ViewCount:     viewCount,
		CategoryCount: categoryCount,
		TagCount:      tagCount,
		BlogConfig:    blogConfigVO,
		Banners:       banners,
		Sentence:      sentence,
	}

}
