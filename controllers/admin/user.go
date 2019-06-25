package admin

import (
	"fmt"
	"quickstart/models/admin"
)

type UserController struct {
	BaseController
}

var model = new(admin.User)

type Paginator struct {
	num		int		//	循环次数
	page	int		//	当前页
	limit	int		//	偏移量
	count	int		//	总记录数
}

func (this *UserController) Index() {
	if this.Ctx.Input.IsAjax() {
		page,_ := this.GetInt("page")
		limit,_ := this.GetInt("limit")
		if limit == 0 {
			limit = 1
		}

		result, count := model.FindAll((page-1)*limit, limit)

		this.JsonReuturn(0, "ok", result, count)
	}
	this.Data["t"] = &TmpField{"用户列表", "", ""}
	this.fetch()
}

func (this *UserController) SetStatus() {
	//if this.Ctx.Input.IsAjax() {
	//	id,idErr := this.GetInt("id")
	//	status, statusErr := this.GetInt("status")
	//	if idErr != nil || statusErr != nil {
	//		this.JsonReuturn(0, "请求参数错误")
	//	} else {
	//		code, msg := model.SetStatus(id, status)
	//		this.JsonReuturn(code, msg)
	//	}
	//} else {
	//	this.JsonReuturn(0, "请求错误")
	//}
	fmt.Println("12313132131")
	this.fetch("index.tpl")
}

func (this *UserController) Test() {
	this.fetch()
}