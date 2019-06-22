package admin

import (
	"github.com/astaxie/beego"
	"strings"
)

type BaseContorller struct {
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

// 前期准备
func (this *BaseContorller) Prepare() {
	// 控制器和方法名
	this.controllerName, this.actionName = this.GetControllerAndAction()
	this.controllerName = strings.Replace(this.controllerName, beego.AppConfig.String("appname") + "/", "", 1)
	this.controllerName = strings.Replace(this.controllerName, "Controller", "", 1)
	this.controllerName = strings.ToLower(this.controllerName)
	this.actionName = strings.ToLower(this.actionName)
	// 当前模型名称
	this.modelName = "admin"
}

// 渲染模板
func (this *BaseContorller) fetch(tpl ...string) {
	if len(tpl) > 0 {
		this.TplName = tpl[0]
	} else {
		//this.TplName = this.Ctx.Request.URL.String() + ".tpl"
		this.TplName = this.modelName + "/" + this.controllerName + "/" + this.actionName + ".tpl"
	}
}
