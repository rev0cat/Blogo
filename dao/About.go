package dao

import (
	"Blogo/model/resp"
)

// 关于页面
type About struct {
}

/* 前台 */
func (*About) GetAbout() resp.AboutVO {
	var aboutVO resp.AboutVO
	db := DB.Table("about").
		Select("about.id, qr_code, team_img, frontend_id, backend_id, frontend_img, backend_img, " +
			"introduction, about.show, location, email, dictum_id").
		Where("showing = 1")
	db.
		//Joins("JOIN dictum ON dictum.id = about.dictum_id").
		//Preload("Experience").
		Find(&aboutVO)
	return aboutVO
}

//func (*About) GetExperiences() ([]model.Experience, int64) {
//	list := make([]model.Experience, 0)
//	var total int64
//	DB.Table("experience").
//		Select("id, pic, title, content")
//	DB.Count(&total).
//		Order("id DESC").
//		Find(&list)
//	return list, total
//}
