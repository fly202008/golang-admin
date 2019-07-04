package admin

import (
	"fmt"
	"github.com/astaxie/beego"
	"quickstart/models/admin"
	"quickstart/pkg/d"
	"strings"
)

type BaseController struct {
	beego.Controller
	modelName			string
	controllerName 		string
	actionName 			string
}

// include模板数据
type TmpField struct {
	Title 			string
	Head 			string
	BottomJs 		string
}

// 请求路径
type request struct {
	Module			string
	Controller		string
	Action			string
}

// 前期准备
func (this *BaseController) Prepare() {
	// 控制器和方法名
	this.controllerName, this.actionName = this.GetControllerAndAction()
	this.controllerName = strings.Replace(this.controllerName, beego.AppConfig.String("appname") + "/", "", 1)
	this.controllerName = strings.Replace(this.controllerName, "Controller", "", 1)
	this.controllerName = strings.ToLower(this.controllerName)
	this.actionName = strings.ToLower(this.actionName)
	// 当前模型名称
	this.modelName = "admin"

	// 验证登录
	if this.GetSession("info") == nil {
		// 查询是否自动登录
		if this.Ctx.GetCookie("remember") != "" && this.Ctx.GetCookie("username") != "" && this.Ctx.GetCookie("password") != "" {
			var user admin.User
			err := admin.Db.Where("username = ?", this.Ctx.GetCookie("username")).First(&user).Error
			if err !=nil || d.MD5(user.Password + user.Salt) != this.Ctx.GetCookie("password") {
				fmt.Println("remember login err = ", err)
			} else {
				this.SetSession("info", user)
			}
		} else {
			this.Redirect("/admin/login", 301)
		}
	}
}

// 渲染模板
func (this *BaseController) fetch(tpl ...string) {
	// 输出请求路径
	this.Data["Request"] = &request{Module:this.modelName, Controller:this.controllerName, Action:this.actionName}

	if len(tpl) > 0 {
		this.TplName = tpl[0]
	} else {
		//this.TplName = this.Ctx.Request.URL.String() + ".tpl"
		this.TplName = this.modelName + "/" + this.controllerName + "/" + this.actionName + ".tpl"
	}
}

// layui table 返回数据
func (this *BaseController) JsonReuturn(code int, msg string, data ...interface{}) {
	if len(data) > 1 {
		this.Data["json"] = d.LayuiJson(code, msg, data[0], data[1])
	} else if len(data) > 0 {
		this.Data["json"] = d.LayuiJson(code, msg, data[0])
	} else {
		this.Data["json"] = d.LayuiJson(code, msg)
	}
	this.ServeJSON()
	this.StopRun()
}
