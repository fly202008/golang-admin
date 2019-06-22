package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
)

type CopyController struct {
	beego.Controller
}

func (this *CopyController) Get() {
	fmt.Println("copy lst")
	//this.TplName = "copy.tpl"

}