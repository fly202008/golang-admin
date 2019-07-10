package admin

type BookCopyController struct {
	BaseController
}

type Book struct {
	Id int
	Name string
	Info string
	BookUrl string
	BookCopy string
}

func (this BaseController) BookInfo() {

}