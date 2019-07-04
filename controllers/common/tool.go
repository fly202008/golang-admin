package common

import (
	"github.com/astaxie/beego"
	"quickstart/pkg/z"
)

type ToolController struct {
	beego.Controller
}

// AJAX获取验证码
func (this *ToolController) Captcha() {
	if this.Ctx.Input.IsAjax() {
		var captchaType string
		captchaType = this.GetString("vtype")
		capid, baseimg := z.DemoCodeCaptchaCreate(captchaType)

		this.Data["json"] =  map[string]interface{}{"code": 1, "data": baseimg, "capid": capid, "msg": "success"}
	} else {
		//设置json响应
		this.Data["json"] =  map[string]interface{}{"code": 0, "msg": "error"}
	}
	this.ServeJSON()
}
