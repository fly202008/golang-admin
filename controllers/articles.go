package controllers

import "github.com/astaxie/beego"

type ArticlesContorller struct {
	beego.Controller
}

func (this *ArticlesContorller) Index() {
	this.TplName = "article.tpl"
}