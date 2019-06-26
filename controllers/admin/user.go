package admin

import (
	"quickstart/models/admin"
)

type UserController struct {
	BaseController
}

var model = new(admin.User)

// 数据列表
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

// 设置数据状态
func (this *UserController) SetStatus() {
	if this.Ctx.Input.IsAjax() {
		id,idErr := this.GetInt("id")
		status, statusErr := this.GetInt("status")
		if idErr != nil || statusErr != nil {
			this.JsonReuturn(0, "请求参数错误")
		} else {
			code, msg := model.SetStatus(id, status)
			this.JsonReuturn(code, msg)
		}
	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// 修改
func (this *UserController) Edit() {
	id,idErr := this.GetInt("id")
	data, err := model.Find(id)
	if idErr != nil || err != nil {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	}
	this.Data["data"] = data

	this.Data["t"] = &TmpField{"用户修改", "", ""}
	this.fetch()
}

// AjaxEdit
func (this *UserController) AjaxEdit() {
	if this.Ctx.Input.IsAjax() {
		var data admin.User
		if err := this.ParseForm(data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		code, msg := model.Save(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求参数错误")
	}
}