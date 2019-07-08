package index

type IndexController struct {
	BaseController
}

func (this *IndexController) Index() {
	this.fetch()
}
