package main

import (
	"Blogo/routes"
	"golang.org/x/sync/errgroup"
	"log"
)

var g errgroup.Group

func main() {
	// 初始化
	routes.InitGlobalVariables()

	// 前台接口服务
	g.Go(func() error {
		return routes.FrontendServer().
			ListenAndServeTLS("../ssl/blogo.revocat.tech_bundle.crt", "../ssl/blogo.revocat.tech.key")
	})

	// 后台接口服务
	g.Go(func() error {
		return routes.BackendServer().
			ListenAndServeTLS("../ssl/blogo.revocat.tech_bundle.crt", "../ssl/blogo.revocat.tech.key")
	})

	if err := g.Wait(); err != nil {
		log.Fatal(err)
	}
}
