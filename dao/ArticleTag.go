package dao

import "Blogo/model"

type ArticleTag struct{}

// 文章-分类关联关系
func (*ArticleTag) CreateArticleTag(articleID, tagID int) error {
	data := &model.ArticleTag{
		ArticleId: articleID,
		TagId:     tagID,
	}
	err := DB.Create(data).Error
	return err
}

// 删除关联关系
func (*ArticleTag) DeleteArticleTag(articleID int) {
	// 删除原本标签
	if articleID != 0 {
		Delete(model.ArticleTag{}, "article_id = ?", articleID)
	}
}
