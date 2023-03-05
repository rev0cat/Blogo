package dao

import (
	"errors"
	"gorm.io/gorm"
)

// 数据库指针
var DB *gorm.DB

// 通用CURD

// 创建数据
func Create[T any](data *T) {
	err := DB.Create(&data).Error
	if err != nil {
		panic(err)
	}
}

// 单条数据查询
func GetOne[T any](data T, query string, args ...any) T {
	err := DB.Where(query, args).First(&data).Error
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		panic(err)
	}
	return data
}

// 单行更新:传入对应结构体(用于传递主键)和带有对应更新字段的结构体，结构体不更新零值
func Update[T any](data *T, slt ...string) {
	if len(slt) > 0 {
		DB.Model(&data).Select(slt).Updates(&data)
		return
	}
	err := DB.Model(&data).Updates(&data).Error
	if err != nil {
		panic(err)
	}
}

// 批量更新，map的字段就是要更新的字段，可以更新零值，可以实现单行更新
func UpdatesMap[T any](data *T, maps map[string]any, query string, args ...any) {
	err := DB.Model(&data).Where(query, args...).Updates(maps).Error
	if err != nil {
		panic(err)
	}
}

// 批量更新，结构体形式
func Updates[T any](data *T, query string, args ...any) {
	err := DB.Model(&data).Where(query, args...).Updates(&data).Error
	if err != nil {
		panic(err)
	}
}

// 数据列表
func List[T any](data T, slt, order, query string, args ...any) T {
	db := DB.Model(&data).Select(slt).Order(order)
	if query != "" {
		db = db.Where(query, args)
	}
	if err := db.Find(&data).Error; err != nil {
		panic(err)
	}
	return data
}

// 批量删除数据
func Delete[T any](data T, query string, args ...any) {
	err := DB.Where(query, args...).Delete(&data).Error
	if err != nil {
		panic(err)
	}
}

// 统计数量
func Count[T any](data T, query string, args ...any) int64 {
	var total int64
	db := DB.Model(data)
	if query != "" {
		db = db.Where(query, args...)
	}
	if err := db.Count(&total).Error; err != nil {
		panic(err)
	}
	return total
}
