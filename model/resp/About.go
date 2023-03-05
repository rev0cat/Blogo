package resp

import "Blogo/model"

type AboutVO struct {
	model.About
	Experience []model.Experience `form:"experience" json:"experience" gorm:"foreignKey:AboutID;"`
	//IsLike     bool               `json:"is_like"`
}

type DictumVO struct {
	model.Dictum
}

type ExperienceVO struct {
	model.Experience
}
