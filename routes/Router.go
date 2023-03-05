package routes

import (
	"Blogo/config"
	"Blogo/dao"
	"Blogo/utils"
	"log"
	"net/http"
	"time"
)

// 初始化全局变量
func InitGlobalVariables() {
	utils.InitViper()
	utils.InitLogger()
	dao.DB = utils.InitMySQL()
	utils.InitRedis()
	utils.InitCasbin(dao.DB)
	utils.InitRegexp()
	utils.InitElasticsearch()
}

// 前台服务
func FrontendServer() *http.Server {
	frontPort := config.Cfg.Server.FrontPort
	log.Printf("前台服务启动于 %s 端口", frontPort)
	return &http.Server{
		Addr:         frontPort,
		Handler:      FrontRouter(),
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}
}

// 后台服务
func BackendServer() *http.Server {
	backPort := config.Cfg.Server.BackPort
	log.Printf("后台服务启动于 %s 端口", backPort)
	return &http.Server{
		Addr:         backPort,
		Handler:      BackRouter(),
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}
}
