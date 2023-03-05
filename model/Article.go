package model

import "reflect"

const (
	PUBLIC = iota + 1 // 公开
	SECRET            // 私密
	DRAFT             // 草稿
)

type Article struct {
	BaseModel

	CategoryID  int    `gorm:"type:bigint;not null;comment:分类ID" json:"category_id"`
	UserId      int    `gorm:"type:int;not null;comment:用户ID" json:"userId"`
	Title       string `gorm:"type:varchar(100);not null;comment:文章标题" json:"title"`
	Desc        string `gorm:"type:varchar(200);not null;comment:文章描述" json:"desc"`
	Content     string `gorm:"type:longtext;comment:正文" json:"content"`
	Img         string `gorm:"type:varchar(100);comment:封面图片地址" json:"img"`
	Type        int    `gorm:"type:bool;comment:类型(1原创 2转载 3翻译)" json:"type"`
	Status      int8   `gorm:"type:bool;commnet:状态(True公开 False私密)" json:"status"`
	IsTop       *int8  `gorm:"type:bool;not null;default:0;comment:是否置顶(True置顶 False不置顶)" json:"isTop"`
	IsDelete    *int8  `gorm:"type:bool;not null;default:0;comment:是否放到回收站(True放 False不放)" json:"isDelete"`
	OriginalUrl string `gorm:"type:varchar(100);comment:转载源链接" json:"originalUrl"`
}

// Article是否为空 使用DeepEqual对比两个结构体
func (a *Article) isEmpty() bool {
	return reflect.DeepEqual(a, &Article{})
}

// 文章和标签关联，不用外键
type ArticleTag struct {
	ArticleId int
	TagId     int
}
