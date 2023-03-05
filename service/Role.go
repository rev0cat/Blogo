package service

import (
	"Blogo/model/req"
	"Blogo/model/resp"
)

type Role struct{}

// 获取用户角色列表
func (*Role) GetOption() []resp.OptionVO {
	return roleDAO.GetOption()
}

// 查询角色列表
func (*Role) GetTreeList(req req.PageQuery) resp.PageResult[[]resp.RoleVO] {
	treeList := make([]resp.RoleVO, 0)
	// 角色列表
	list, total := roleDAO.GetList(req)
	// 构造角色列表
	for _, role := range list {
		// 根据角色ID查资源ID列表
		role.ResourceIDs = roleDAO.GetResourcesByRoleID(role.ID)
		// 查菜单列表
		role.MenuIDs = roleDAO.GetMenusByRoleID(role.ID)
		treeList = append(treeList, role)
	}
	return resp.PageResult[[]resp.RoleVO]{
		PageSize: req.PageSize,
		PageNum:  req.PageNum,
		Total:    total,
		List:     treeList,
	}
}
