package utils

import (
	"Blogo/config"
	"flag"
	"log"
	"strings"

	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
)

// 优先级：命令行参数 >  默认值
func InitViper() {
	var configPath string
	flag.StringVar(&configPath, "c", "", "choose config file path.")
	flag.Parse()
	if configPath != "" {
		log.Printf("命令行参数配置文件路径：%s\n", configPath)
	} else {
		log.Println("命令行参数配置文件路径为空，使用默认配置文件路径config/config.toml")
		configPath = "./config/config.toml"
	}

	// 读取配置文件
	v := viper.New()
	v.SetConfigFile(configPath)
	v.AutomaticEnv()                                   // 允许使用环境变量
	v.SetEnvKeyReplacer(strings.NewReplacer(".", "_")) // SERVER_APPMODE => SERVER.APPMODE

	// 读取配置文件
	if err := v.ReadInConfig(); err != nil {
		log.Panic("配置文件读取失败:", err)
	}

	// 加载配置文件内容到结构体对象
	if err := v.Unmarshal(&config.Cfg); err != nil {
		log.Panic("配置文件内容加载失败:", err)
	}

	// 配置文件热重载
	v.WatchConfig()
	v.OnConfigChange(func(e fsnotify.Event) {
		log.Println("检测到配置文件内容修改")
		if err := v.Unmarshal(&config.Cfg); err != nil {
			log.Panic("配置文件内容加载失败: ", err)
		}
	})

	log.Println("配置文件内容加载成功!")
}
