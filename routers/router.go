package routers

import (
	"github.com/astaxie/beego"
	"quickstart/controllers"
	"quickstart/controllers/admin"
	"quickstart/controllers/common"
)

func init() {
	beego.AutoRouter(&controllers.CopyController{})
	beego.Router("/", &controllers.MainController{})
	//beego.Router("/copy", &controllers.CopyControllers{}, "*:Index")
	//beego.AutoRouter("/copy", &controllers.CopyControllers{})
	beego.Router("/articles/index", &controllers.ArticlesContorller{}, "*:Index")
	//beego.Router("/admin", &admin.IndexController{}, "get:Index")
	//beego.Router("/admin/index/main", &admin.IndexController{}, "get:Main")

	// 工具管理
	common := beego.NewNamespace("common",
		beego.NSNamespace("/tool",
			// 验证码
			beego.NSRouter("/captcha", &common.ToolController{}, "get:Captcha"),
		),
	)
	beego.AddNamespace(common)


	// 后台
	ns := beego.NewNamespace("/admin",
		// 首页
		beego.NSRouter("/", &admin.IndexController{}, "get:Index"),
		beego.NSRouter("index/main", &admin.IndexController{}, "get:Main"),

		// 登录
		beego.NSRouter("/login", &admin.LoginController{},"*:Login"),

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
			beego.NSRouter("/ajaxDel", &admin.UserController{}, "get:AjaxDel"),
			// 批量删除
			beego.NSRouter("/ajaxDelAll", &admin.UserController{}, "post:AjaxDelAll"),
		),
	)
	beego.AddNamespace(ns)
}
