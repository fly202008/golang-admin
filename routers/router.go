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
			// 设置用户状态
			beego.NSRouter("/setStatus", &admin.UserController{}, "get:SetStatus"),
			// 修改
			beego.NSRouter("/edit", &admin.UserController{}, "get:Edit"),
			beego.NSRouter("/ajaxEdit", &admin.UserController{}, "post:AjaxEdit"),
			// 添加
			beego.NSRouter("/add", &admin.UserController{}, "get:Add"),
			beego.NSRouter("/ajaxAdd", &admin.UserController{}, "post:AjaxAdd"),
			// 删除
			//beego.NSRouter("/del", &admin.UserController{}, "get:Del"),
			//beego.NSRouter("/ajaxDel", &admin.UserController{}, "get:AjaxDel"),
			// 批量删除
			//beego.NSRouter("/ajaxDelAll", &admin.UserController{}, "get:AjaxDelAll"),
		),
	)
	beego.AddNamespace(ns)
}
