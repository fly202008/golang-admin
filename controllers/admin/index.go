package admin

import (
	"github.com/astaxie/beego"
	"runtime"
)

type IndexController struct {
	BaseController
}

func (this *IndexController) Index() {
	this.fetch()
}

func (this *IndexController) Main() {
	this.Data["t"] = &TmpField{"主页", "", ""}
	goVersion := runtime.Version()
	os := runtime.GOOS
	beegoVersion := beego.VERSION
	this.Data["goVersion"] = goVersion
	this.Data["os"] = os
	this.Data["beegoVersion"] = beegoVersion
	this.fetch()
}