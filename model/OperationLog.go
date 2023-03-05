package model

// 操作日志
type OperationLog struct {
	BaseModel
	OptModule string `gorm:"type:varchar(50);comment:操作模块" json:"optModule"`
	OptUrl    string `gorm:"type:varchar(255);comment:操作路径" json:"optUrl"`
	OptType   string `gorm:"type:varchar(50);comment:操作类型" json:"optType"`
	OptMethod string `gorm:"type:varchar(50);comment:操作方法" json:"optMethod"`
	OptDesc   string `gorm:"type:varchar(255);comment:操作描述" json:"optDesc"`

	ReqMethod string `gorm:"type:longtext;comment:请求方法" json:"reqMethod"`
	ReqParam  string `gorm:"type:longtext;comment:请求参数" json:"reqParam"`
	RespData  string `gorm:"type:longtext;comment:返回数据" json:"respData"`

	UserID    int    `gorm:"comment:用户ID" json:"userId"`
	Nickname  string `gorm:"comment:用户昵称" json:"nickname"`
	IPAddress string `gorm:"comment:IP地址" json:"ipAddress"`
	IPSource  string `gorm:"comment:IP来源" json:"ipSource"`
}
