package config

var Cfg Config

type Config struct {
	Server        Server
	JWT           JWT
	Mysql         Mysql
	Redis         Redis
	Session       Session
	Upload        Upload
	Zap           Zap
	Qiniu         Qiniu
	Email         Email
	Elasticsearch Elasticsearch
}

type Server struct {
	AppMode   string
	BackPort  string
	FrontPort string
}

type JWT struct {
	Secret string // JWT 签名
	Expire int64  // 过期时间
	Issuer string // 签发者
}

type Mysql struct {
	Host     string // 服务器地址
	Port     string // 端口
	Config   string // 高级配置
	Dbname   string // 数据库名
	Username string // 数据库用户名
	Password string // 数据库密码
	LogMode  string // 日志级别
}

type Redis struct {
	DB       int    // 指定 Redis 数据库
	Addr     string // 服务器地址:端口
	Password string // 密码
}

type Session struct {
	Name   string
	Salt   string
	MaxAge int
}

type Upload struct {
	// Size int    // 文件上传的最大值
	OssType     string // 存储类型
	Path        string // 本地文件访问路径
	StorePath   string // 本地文件存储路径
	Url         string
	MdPath      string // Markdown 访问路径
	MdStorePath string // Markdown 存储路径
}

type Zap struct {
	Level         string // 日志级别
	Format        string // 日志格式
	Prefix        string // 日志前缀
	Directory     string // 日志文件保存路径
	LinkName      string // 日志文件软链
	ShowLine      bool   // 是否显示行号
	EncodeLevel   string // 编码级别
	StacktraceKey string // 堆栈跟踪键
	LogInConsole  bool   // 是否在控制台打印=
}

type Qiniu struct {
	AccessKey string
	SecretKey string
	Bucket    string
	Zone      string
	ImgPath   string
}

type Email struct {
	Username string
	Password string
	Host     string
	Port     int
}

type Elasticsearch struct {
	Address string
}
