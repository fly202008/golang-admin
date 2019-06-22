package routers

import (
	"quickstart/controllers"
	"github.com/astaxie/beego"
	"quickstart/controllers/admin"
)

func init() {
	beego.AutoRouter(&controllers.CopyController{})
	beego.Router("/", &controllers.MainController{})
	//beego.Router("/copy", &controllers.CopyControllers{}, "*:Index")
	//beego.AutoRouter("/copy", &controllers.CopyControllers{})
	beego.Router("/articles/index", &controllers.ArticlesContorller{}, "*:Index")
	//beego.Router("/admin", &admin.IndexController{}, "get:Index")
	//beego.Router("/admin/index/main", &admin.IndexController{}, "get:Main")

	// 后台
	ns := beego.NewNamespace("/admin",
		// 首页
		beego.NSRouter("/", &admin.IndexController{}, "get:Index"),
		beego.NSRouter("index/main", &admin.IndexController{}, "get:Main"),

		// 用户管理
		beego.NSNamespace("/user",
			// 列表
			beego.NSRouter("/index", &admin.UserController{}, "get:Index"),
			),
		)
	beego.AddNamespace(ns)
}
