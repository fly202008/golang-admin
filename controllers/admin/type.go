package admin

type TypeContorller struct {
	BaseController
}

func (this *TypeContorller) Index() {
	this.fetch()
}