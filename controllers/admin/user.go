package admin

type UserController struct {
	BaseContorller
}

func (this *UserController) Index() {
	this.Data["t"] = &TmpField{"用户列表", "", ""}

	this.fetch()
}