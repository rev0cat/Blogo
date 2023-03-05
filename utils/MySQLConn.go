package utils

import (
	"Blogo/config"
	"Blogo/model"
	"fmt"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"gorm.io/gorm/schema"
	"log"
	"time"
)

func InitMySQL() *gorm.DB {
	cfg := config.Cfg.Mysql
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		cfg.Username,
		cfg.Password,
		cfg.Host,
		cfg.Port,
		cfg.Dbname,
	)

	DB, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		SkipDefaultTransaction: true, // 禁用默认事物，提高性能
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true, // 启用单数表名，此时User的表名是user
		},
		Logger:                                   logger.Default.LogMode(getLogMode(config.Cfg.Mysql.LogMode)), // 读取日志模式
		DisableForeignKeyConstraintWhenMigrating: true,                                                         // 禁用外键约束
	})

	if err != nil {
		log.Fatal("MySQL连接失败，请检查参数！")
	}

	log.Println("MySQL连接成功！")

	// 迁移数据表，数据表结构未变更时建议注释不执行
	//autoMigrate(DB)

	sqlDB, _ := DB.DB()
	sqlDB.SetMaxIdleConns(10)                  // 连接池中的最大闲置连接
	sqlDB.SetMaxOpenConns(100)                 // 数据库最大连接数量
	sqlDB.SetConnMaxLifetime(10 * time.Second) //连接最大可复用时间

	return DB
}

// 根据字符串获取LogLevel
func getLogMode(str string) logger.LogLevel {
	switch str {
	case "silent", "Silent":
		return logger.Silent
	case "error", "Error":
		return logger.Error
	case "warn", "Warn":
		return logger.Warn
	case "info", "Info":
		return logger.Info
	default:
		return logger.Info
	}
}

// 迁移数据表，在没有数据表结构变更时候，建议注释不执行
// 只支持创建表、增加表中没有的字段和索引
// 为了保护数据，并不支持改变已有的字段类型或删除未被使用的字段
func autoMigrate(db *gorm.DB) {
	err := db.AutoMigrate(
		&model.Article{},
		&model.Category{},
		&model.Comment{},
		&model.Tag{},
		&model.Message{},
		&model.UserInfo{},
		&model.FriendLink{},
		// 权限相关
		&model.UserAuth{},     // 用户
		&model.Role{},         // 角色
		&model.Menu{},         // 菜单
		&model.Resource{},     // 资源(接口)
		&model.UserRole{},     // 用户-角色 关联
		&model.RoleMenu{},     // 角色-菜单 关联
		&model.RoleResource{}, // 角色-资源 关联

		&model.Page{},         // 页面
		&model.BlogConfig{},   // 网站设置
		&model.OperationLog{}, // 操作日志
	)

	if err != nil {
		log.Println("gorm 自动迁移失败: ", err)
	} else {
		log.Println("gorm 自动迁移成功")
	}
}
