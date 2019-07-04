package admin

import (
	"fmt"
	"github.com/astaxie/beego"
	"quickstart/models/admin"
	"quickstart/pkg/d"
	"quickstart/pkg/z"
)

type LoginController struct {
	beego.Controller
}

func (this *LoginController) Login() {
	a := this.GetSession("info")
	fmt.Println("session info = ", a)
	if this.Ctx.Input.IsAjax() {
		var re admin.User
		username := this.GetString("username")
		password := d.MD5(this.GetString("password"))
		capid := this.GetString("capid")
		captcha := this.GetString("captcha")

		err := admin.Db.Where("username = ?", username).Where("password = ?", password).First(&re).Error
		if err != nil {
			fmt.Println("login err = ", err)
		}
		// 验证
		vcode := z.VerfiyCaptcha(capid, captcha)
		if vcode != 1 {
			code := 0
			msg := "验证码错误"
			this.Data["json"] = d.ReturnJson(code, msg)
		} else if re.Id == 0 {
			code := 0
			msg := "账号或密码错误"
			this.Data["json"] = d.ReturnJson(code, msg)
		} else {
			code := 1
			msg := "登录成功"
			// 设置session
			this.SetSession("info", re)
			this.Data["json"] = d.ReturnJson(code, msg, re)
		}
		this.ServeJSON()
		this.StopRun()
	}
	//captchaId,imgBase64 := z.DemoCodeCaptchaCreate("number")
	//this.Data["Vcode"] = template.URL(imgBase64)
	//this.Data["capid"] = captchaId
	this.TplName = "admin/login/index.tpl"
}
