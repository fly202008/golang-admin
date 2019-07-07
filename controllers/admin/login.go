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
	//info_session := this.GetSession("info")
	//fmt.Println(info_session);
	//a := this.GetSession("info")
	//fmt.Println("session info = ", a)
	//b := this.Ctx.GetCookie("username")
	//c := this.Ctx.GetCookie("password")
	//dd := this.Ctx.GetCookie("remember")
	//fmt.Println("cookie username = ", b)
	//fmt.Println("cookie password = ", c)
	//fmt.Println("cookie remember = ", dd)

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
			// 查看是否自动登录
			remember,err := this.GetInt("remember")
			fmt.Println("post remember = ", remember)
			fmt.Printf("post remember type = %T\n ", remember)
			if err != nil  || (remember != 3 && remember != 7 && remember != 15) {
				remember = 0
			}
			fmt.Println("err = ", err)
			fmt.Println("remember = ", remember)
			// 设置cookie自动登录
			if remember != 0 {
				this.Ctx.SetCookie("remember", "1", remember * 86400)
				this.Ctx.SetCookie("username", re.Username, remember * 86000)
				this.Ctx.SetCookie("password", d.MD5(re.Password + re.Salt), remember * 86000)
			}
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
