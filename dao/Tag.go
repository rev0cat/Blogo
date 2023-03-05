package dao

import (
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Tag struct{}

// 获取Tag列表
func (*Tag) GetList(req req.PageQuery) ([]resp.TagVO, int64) {
	var datas = make([]resp.TagVO, 0)
	var total int64

	db := DB.Table("tag t").
		Select("t.id, t.name, COUNT(at.article_id) AS article_count, t.created_at, t.updated_at").
		Joins("LEFT JOIN article_tag at ON t.id = at.tag_id")
	if req.Keyword != "" {
		db = db.Where("name LIKE", "%"+req.Keyword+"%")
	}
	db.Group("t.id").
		Order("t.id DESC").
		Count(&total).
		Find(&datas)
	return datas, total
}

func (*Tag) GetOption() []resp.OptionVO {
	var list = make([]resp.OptionVO, 0)
	DB.Model(&model.Tag{}).
		Select("id", "name").
		Find(&list)
	return list
}

// 根据文章ID获取标签列表名称
func (*Tag) GetTagNamesByArticleID(id int) []string {
	list := make([]string, 0)
	DB.Table("tag").
		Joins("LEFT JOIN article_tag ON tag.id = article_tag.tag_id").
		Where("artcle_id", id).
		Pluck("name", &list)
	return list
}

// 根据ID获取标签
func GetTagByID(id int) string {
	res := GetOne(model.Tag{}, "id = ?", id)
	resStr := res.Name
	return resStr
}
