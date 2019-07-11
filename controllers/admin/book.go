package admin

import (
	"fmt"
	"quickstart/models/admin"
)

type BookController struct {
	BaseController
}

var bookModel admin.Book

// 首页
func (this *BookController) Index() {
	// 搜索关键字
	var where admin.BookWhere
	where.Status = 1
	where.Typeid,_ = this.GetInt("typeid")
	where.Name = this.GetString("name")
	where.Author = this.GetString("author")
	this.Data["where"] = where
	if this.Ctx.Input.IsAjax() {
		result, count := bookModel.FindAll(where)
		this.JsonReuturn(0, "ok", result, count)
	}
	this.fetch()
}

// 添加
func (this *BookController) Add() {
	typeData := typeModel.GetList()
	this.Data["typeData"] = typeData
	//id,_ := this.GetInt("typeid")
	//this.Data["typeid"] = id
	//book := copy.GetBookInfo("https://www.qu.la/book/172684/")
	this.Data["t"] = &TmpField{"书籍添加", "", ""}
	this.fetch()
}
// AjaxAdd
func (this *BookController) AjaxAdd() {
	if this.Ctx.Input.IsAjax() {
		// 采集
		//url := "https://sou.xanbhx.com/search?siteid=qula&q="
		name := this.GetString("name")
		url := this.GetString("url")
		typeid,_ := this.GetInt("typeid")
		// 采集指定书籍
		book := bookModel.SearchBook(url + name,typeid)
		fmt.Println("re = ",book)

		// 保存
		//code, msg := bookModel.AddAll(book)
		//this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// 设置数据状态
func (this *BookController) SetStatus() {
	if this.Ctx.Input.IsAjax() {
		id,idErr := this.GetInt("id")
		status, statusErr := this.GetInt("status")
		if idErr != nil || statusErr != nil {
			this.JsonReuturn(0, "请求参数错误")
		} else {
			code, msg := bookModel.SetStatus(id, status)
			this.JsonReuturn(code, msg)
		}
	} else {
		this.JsonReuturn(0, "请求错误")
	}
}

// 修改
func (this *BookController) Edit() {
	id,idErr := this.GetInt("id")
	data, err := bookModel.Find(id)
	if idErr != nil || err != nil {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	}
	this.Data["data"] = data

	this.Data["t"] = &TmpField{"用户修改", "", ""}
	this.fetch()
}
// AjaxEdit
func (this *BookController) AjaxEdit() {
	if this.Ctx.Input.IsAjax() {
		//var data admin.User
		data := admin.Book{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		// 保存
		//fmt.Printf("C data.Id = %d, data.Status = %d,  data.Password = %v\r", data.Id, data.Status, data.Password)
		code, msg := bookModel.Save(data)
		this.JsonReuturn(code, msg)

	} else {
		this.JsonReuturn(0, "请求参数错误")
	}
}

// Ajax删除
func (this *BookController) AjaxDel() {
	id,idErr := this.GetInt("id")
	if idErr != nil || id == 0 {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := bookModel.AjaxDel(id)
		this.JsonReuturn(code, msg)
	}
}

// Ajax批量删除
func (this *BookController) AjaxDelAll() {
	ids := this.GetString("ids")
	if ids == "" {
		this.JsonReuturn(0, "请求参数错误,未查询到数据")
	} else {
		code, msg := bookModel.AjaxDelAll(ids)
		this.JsonReuturn(code, msg)
	}
}


