package main

import (
	"quickstart/models/admin"
	_ "quickstart/routers"
	"github.com/astaxie/beego"
	"time"
)
func _date(t int64)(out string){
	if t == 0 {
		out = ""
	} else {
		out = beego.Date(time.Unix(t, 0), "Y-m-d H:i:s")
	}
	return
}


func main() {
	beego.AddFuncMap("_date",_date)
	admin.Init()
	beego.Run()
}

