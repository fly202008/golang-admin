package main

import (
	"quickstart/models/admin"
	_ "quickstart/routers"
	"github.com/astaxie/beego"
)

func main() {
	admin.Init()
	beego.Run()
}

