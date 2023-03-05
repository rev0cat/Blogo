package dao

import (
	"Blogo/model"
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Role struct{}

func (*Role) GetLabelsByUserInfoID(userInfoID int) (labels []string) {
	DB.Table("role r, user_role ur").
		Where("r.id = ur.role_id AND ur.user_id = ?", userInfoID).
		Pluck("label", &labels) // 将单列查询为切片
	return
}

// 根据角色ID获取角色标签列表
func (*Role) GetLabelsByRoleIDs(ids []int) (labels []string) {
	DB.Model(model.Role{}).
		Where("id in ?", ids).
		Pluck("label", labels)
	return
}

// 获取角色列表(非树形)
func (*Role) GetList(req req.PageQuery) (list []resp.RoleVO, total int64) {
	list = make([]resp.RoleVO, 0)
	db := DB.Table("role")
	// 查询条件
	if req.Keyword != "" {
		db = db.Where("name LIKE ?", "%"+req.Keyword+"%")
	}
	db.Count(&total).
		Limit(req.PageSize).Offset(req.PageSize * (req.PageNum - 1)).
		Select("id, name, label, created_at, is_disable").
		Find(&list)
	return list, total
}

// 获取角色选项
func (*Role) GetOption() []resp.OptionVO {
	list := make([]resp.OptionVO, 0)
	DB.Model(&model.Role{}).
		Select("id", "name").
		Find(&list)
	return list
}

// 根据角色ID查询资源ID列表
func (*Role) GetResourcesByRoleID(roleID int) (resourceIDs []int) {
	DB.Model(&model.RoleResource{}).
		Where("role_id = ?", roleID).
		Pluck("resource_id", &resourceIDs)
	return
}

// 根据角色ID查询目录ID列表
func (Role) GetMenusByRoleID(roleID int) (menuIDs []int) {
	DB.Model(&model.RoleMenu{}).
		Where("role_id = ?", roleID).
		Pluck("menu_id", &menuIDs)
	return
}
