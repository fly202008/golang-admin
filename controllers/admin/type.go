package admin

import (
	"quickstart/models/admin"
)

type TypeController struct {
	BaseController
}

var typeModel admin.Type

// 列表
func (this *TypeController) Index() {
	// 搜索关键字
	var where admin.TypeWhere
	where.Is_navi,_ = this.GetInt("is_navi")
	where.Name = this.GetString("name")
	this.Data["where"] = where
	if this.Ctx.Input.IsAjax() {
		result, count := typeModel.FindAll(where)
		this.JsonReuturn(0, "ok", result, count)
	}
	//
	this.Data["tree"] = typeModel.DataTree()
	this.fetch()
}

// 栏目tree
func (this *TypeController) DataTree() {

}

// 设置数据状态
func (this *TypeController) SetStatus() {
	if this.Ctx.Input.IsAjax() {
		id,idErr := this.GetInt("id")
		status, statusErr := this.GetInt("status")
		if idErr != nil || statusErr != nil {
			this.JsonReuturn(0, "请求参数错误")
		} else {
			code, msg := typeModel.SetStatus(id, status)
			this.JsonReuturn(code, msg)
		}
	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// 修改
func (this *TypeController) Edit() {
	id,idErr := this.GetInt("id")
	data, err := typeModel.Find(id)
	if idErr != nil || err != nil {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	}
	this.Data["data"] = data

	this.Data["t"] = &TmpField{"栏目修改", "", ""}
	this.fetch()
}
// AjaxEdit
func (this *TypeController) AjaxEdit() {
	if this.Ctx.Input.IsAjax() {
		data := admin.Type{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		code, msg := typeModel.Save(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求参数错误")
	}
}

// 添加
func (this *TypeController) Add() {
	this.Data["t"] = &TmpField{"栏目添加", "", ""}
	this.fetch()
}
// AjaxAdd
func (this *TypeController) AjaxAdd() {
	if this.Ctx.Input.IsAjax() {
		data := admin.Type{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		code, msg := typeModel.Add(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// Ajax删除
func (this *TypeController) AjaxDel() {
	id,idErr := this.GetInt("id")
	if idErr != nil || id == 0 {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := typeModel.AjaxDel(id)
		this.JsonReuturn(code, msg)
	}
}

// Ajax批量删除
func (this *TypeController) AjaxDelAll() {
	ids := this.GetString("ids")
	if ids == "" {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := typeModel.AjaxDelAll(ids)
		this.JsonReuturn(code, msg)
	}
}