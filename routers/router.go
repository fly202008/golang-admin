package routers

import (
	"github.com/astaxie/beego"
	"quickstart/controllers"
	"quickstart/controllers/admin"
	"quickstart/controllers/api"
	"quickstart/controllers/common"
	"quickstart/controllers/index"
)

func init() {
	//beego.AutoRouter(&controllers.CopyController{})
	//beego.Router("/", &controllers.MainController{})
	//beego.Router("/copy", &controllers.CopyControllers{}, "*:Index")
	//beego.AutoRouter("/copy", &controllers.CopyControllers{})
	//beego.Router("/articles/index", &controllers.ArticlesContorller{}, "*:Index")
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

	// 前台
	beego.Router("/bee", &controllers.MainController{})
	beego.Router("/", &index.IndexController{},"get:Index")
	beego.Router("/list", &index.IndexController{},"get:List")
	beego.Router("/book/", &index.IndexController{},"get:Book")
	beego.Router("/cs/?:id", &index.IndexController{},"get:Cs")
	//beego.Router("/list/:id", &home.HomeController{}, "get:List")
	beego.Router("/article", &index.IndexController{},"get:Article")
	// book搜索
	beego.Router("/search", &index.IndexController{}, "get:Search")
	// register
	beego.Router("/register", &index.IndexController{}, "*:Register")
	// login
	beego.Router("/login", &index.IndexController{}, "*:Login")
	// 会员页，书签页
	beego.Router("/member", &index.IndexController{}, "get:Member")
	// 添加书签
	beego.Router("/addbookcase", &index.IndexController{}, "get:AddBookCase")
	// 删除书签
	beego.Router("/delbookcase", &index.IndexController{}, "get:DelBookCase")

	// 退出
	beego.Router("/loginout", &index.IndexController{},"get:LoginOut")

	//ns2 := beego.NewNamespace("/book",
	//	// book首页
	//	beego.NSRouter("/index", &index.IndexController{}, "get:Index"),
	//	// book分类页
	//	beego.NSRouter("/index", &index.IndexController{}, "get:Index"),
	//)
	//beego.AddNamespace(ns2)

	// api
	api_book := beego.NewNamespace("/api",
		beego.NSNamespace("/book",
			// book分类
			beego.NSRouter("/class", &api.BookController{}, "get:ClassList"),
			// book列表
			beego.NSRouter("/list", &api.BookController{}, "get:List"),
			// book内容
			beego.NSRouter("/show", &api.BookController{}, "get:Show"),
			// book章节列表
			beego.NSRouter("/chapter", &api.BookController{}, "get:Chapter"),
			// book章节列表
			beego.NSRouter("/article", &api.BookController{}, "get:Article"),
			// book搜索
			beego.NSRouter("/search", &api.BookController{}, "get:Search"),
		),
	)
	beego.AddNamespace(api_book)


	// 后台
	ns := beego.NewNamespace("/admin",
		// 首页
		beego.NSRouter("/", &admin.IndexController{}, "get:Index"),
		beego.NSRouter("index/main", &admin.IndexController{}, "get:Main"),

		// 登录
		beego.NSRouter("/login", &admin.LoginController{},"*:Login"),
		// 退出
		beego.NSRouter("/loginout", &admin.LoginController{},"*:LoginOut"),

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
		// 栏目管理
		beego.NSNamespace("/type",
			// 列表
			beego.NSRouter("/index", &admin.TypeController{}, "get:Index"),
			// 设置栏目状态
			beego.NSRouter("/setStatus", &admin.TypeController{}, "get:SetStatus"),
			// 修改
			beego.NSRouter("/edit", &admin.TypeController{}, "get:Edit"),
			beego.NSRouter("/ajaxEdit", &admin.TypeController{}, "post:AjaxEdit"),
			// 添加
			beego.NSRouter("/add", &admin.TypeController{}, "get:Add"),
			beego.NSRouter("/ajaxAdd", &admin.TypeController{}, "post:AjaxAdd"),
			// 删除
			beego.NSRouter("/ajaxDel", &admin.TypeController{}, "get:AjaxDel"),
			// 批量删除
			beego.NSRouter("/ajaxDelAll", &admin.TypeController{}, "post:AjaxDelAll"),
		),
		// 书籍管理
		beego.NSNamespace("/book",
			// 列表
			beego.NSRouter("/index", &admin.BookController{}, "get:Index"),
			// 设置栏目状态
			beego.NSRouter("/setStatus", &admin.BookController{}, "get:SetStatus"),
			// 修改
			beego.NSRouter("/edit", &admin.BookController{}, "get:Edit"),
			beego.NSRouter("/ajaxEdit", &admin.BookController{}, "post:AjaxEdit"),
			// 添加
			beego.NSRouter("/add", &admin.BookController{}, "get:Add"),
			beego.NSRouter("/ajaxAdd", &admin.BookController{}, "post:AjaxAdd"),
			// 删除
			beego.NSRouter("/ajaxDel", &admin.BookController{}, "get:AjaxDel"),
			// 批量删除
			beego.NSRouter("/ajaxDelAll", &admin.BookController{}, "post:AjaxDelAll"),
		),
	)
	beego.AddNamespace(ns)
}
