package admin

import (
	"fmt"
	"quickstart/models/admin"
)

type UserController struct {
	BaseController
}

var model = new(admin.User)



// 数据列表
func (this *UserController) Index() {
	// 搜索关键字
	var where admin.UserWhere
	where.Status,_ = this.GetInt("status")
	where.Time1 = this.GetString("time1")
	where.Time2 = this.GetString("time2")
	where.Username = this.GetString("username")
	this.Data["where"] = where

	if this.Ctx.Input.IsAjax() {
		page,_ := this.GetInt("page")
		limit,_ := this.GetInt("limit")
		if limit == 0 {
			limit = 1
		}

		result, count := model.FindAll((page-1)*limit, limit, where)

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
		//var data admin.User
		data := admin.User{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		//fmt.Printf("C data.Id = %d, data.Status = %d,  data.Password = %v\r", data.Id, data.Status, data.Password)
		code, msg := model.Save(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求参数错误")
	}
}

// 添加
func (this *UserController) Add() {
	this.Data["t"] = &TmpField{"用户添加", "", ""}
	this.fetch()
}
// AjaxAdd
func (this *UserController) AjaxAdd() {
	if this.Ctx.Input.IsAjax() {
		//var data admin.User
		data := admin.User{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		//fmt.Printf("C data.Id = %d, data.Status = %d,  data.Password = %v\r", data.Id, data.Status, data.Password)
		code, msg := model.Add(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// Ajax删除
func (this *UserController) AjaxDel() {
	id,idErr := this.GetInt("id")
	if idErr != nil || id == 0 {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := model.AjaxDel(id)
		this.JsonReuturn(code, msg)
	}
}

// Ajax批量删除
func (this *UserController) AjaxDelAll() {
	ids := this.GetString("ids")
	fmt.Println("ids = ", ids)
	if ids == "" {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := model.AjaxDelAll(ids)
		this.JsonReuturn(code, msg)
	}
}