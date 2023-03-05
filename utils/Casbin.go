package utils

import (
	"github.com/casbin/casbin/v2"
	"github.com/casbin/casbin/v2/model"
	gormAdapter "github.com/casbin/gorm-adapter/v3"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"log"
	"sync"
)

const CasbinUtilErrPrefix = "utils/Casbin.go -> "

var (
	cachedEnforcer *casbin.CachedEnforcer
	casbinDB       *gorm.DB
	once           sync.Once
)

type _casbin struct{}

var Casbin = new(_casbin)

func InitCasbin(db *gorm.DB) *casbin.CachedEnforcer {
	var err error

	once.Do(func() {
		casbinDB = db

		adapter, _ := gormAdapter.NewAdapterByDB(db)

		// 方法一：从字符串加载
		text := `
		[request_definition]
		r = sub, obj, act

		[policy_definition]
		p = sub, obj, act

		[role_definition]
		g = _, _

		[policy_effect]
		e = some(where (p.eft == allow))

		[matchers]
		m = g(r.sub, p.sub) && r.obj == p.obj && r.act == p.act
		`
		m, _ := model.NewModelFromString(text)
		cachedEnforcer, err = casbin.NewCachedEnforcer(m, adapter)
		if err != nil {
			log.Panic("Casbin初始化失败:", err)
		}

		cachedEnforcer.SetExpireTime(60 * 60)
		cachedEnforcer.EnableAutoSave(true)
		_ = cachedEnforcer.LoadPolicy()

		log.Println("Casbin初始化成功！")
	})
	return cachedEnforcer
}

func (*_casbin) Enforcer() *casbin.CachedEnforcer {
	return cachedEnforcer
}

// RBAC API策略
// 为用户添加角色
func (*_casbin) AddRoleForUser(user, role string) {
	_, err := cachedEnforcer.AddRoleForUser(user, role)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"AddRoleForUser:", zap.Error(err))
		panic(err)
	}
}

// 删除用户角色
func (*_casbin) DeleteRoleForUser(user, role string) {
	_, err := cachedEnforcer.DeleteRoleForUser(user, role)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"DeleteRoleForUser:", zap.Error(err))
		panic(err)
	}
}

// 添加API权限
func (c *_casbin) AddPermissionForRole(role string, params ...string) {
	_, err := cachedEnforcer.AddPermissionForUser(role, params...)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"AddPermissionForRole:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 批量添加策略
func (c *_casbin) AddPolicies(rules [][]string) {
	if len(rules) == 0 {
		return
	}
	_, err := cachedEnforcer.AddPolicies(rules)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"AddPolicies:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 删除API权限
func (c *_casbin) DeletePermission(permission ...string) {
	_, err := cachedEnforcer.DeletePermission(permission...)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"DeletePermission:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 删除角色API权限
func (c *_casbin) DeletePermissionForRole(roleLabel string, permissions ...string) {
	_, err := cachedEnforcer.DeletePermissionForUser(roleLabel, permissions...) // 删除该角色对应的API权限
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"DeletePermissionForRole:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 根据角色名批量删除API权限

func (c *_casbin) BatchDeletePermissions(roleLabels []string) {
	for _, roleLabel := range roleLabels {
		_, err := cachedEnforcer.DeletePermissionsForUser(roleLabel)
		if err != nil {
			Logger.Error(CasbinUtilErrPrefix+"BatchDeletePermissions:", zap.Error(err))
			panic(err)
		}
	}
	c.LoadPolicy()
}

// 更新API策略
func (c *_casbin) UpdatePolicy(old []string, new []string) {
	_, err := cachedEnforcer.UpdatePolicy(old, new)
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"UpdatePolicy:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 更新API权限，修改角色名
func (c *_casbin) UpdateRoleLabels(oldLabel, newLabel string) {
	err := casbinDB.Model(&gormAdapter.CasbinRule{}).
		Where("v0=?", oldLabel).Update("v0", newLabel).Error
	if err != nil {
		Logger.Error(CasbinUtilErrPrefix+"UpdateRoleLabels:", zap.Error(err))
		panic(err)
	}
	c.LoadPolicy()
}

// 重新加载策略，更新策略生效
func (*_casbin) LoadPolicy() {
	log.Println("重新加载策略...")
	cachedEnforcer.LoadPolicy()
}
