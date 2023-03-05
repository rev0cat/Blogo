package dao

import (
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Category struct{}

// 获取分类列表
func (*Category) GetList(req req.PageQuery) ([]resp.CategoryVO, int64) {
	var datas = make([]resp.CategoryVO, 0)
	var total int64

	db := DB.Table("category c").
		Select("c.id, c.name, COUNT(a.id) AS article_count, c.created_at, c.updated_at").
		Joins("LEFT JOIN article a ON c.id = a.category_id AND a.is_delete = 0 AND a.status=1")

	//条件查询
	if req.Keyword != "" {
		db = db.Where("name LIKE ?", "%"+req.Keyword+"%")
	}

	db.Group("c.id").
		Order("c.id DESC").
		Count(&total).
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Find(&datas)
	return datas, total
}

func (*Category) GetOption() []resp.OptionVO {
	var list = make([]resp.OptionVO, 0)
	DB.Model(&model.Category{}).Select("id", "name").Find(&list)
	return list
}

// 根据ID获取标签
func GetCategoryByID(id int) string {
	res := GetOne(model.Category{}, "id = ?", id)
	resStr := res.Name
	return resStr
}
