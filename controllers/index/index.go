package index

import (
	"crypto/tls"
	"fmt"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/debug"
	"math/rand"
	"net/http"
	"quickstart/models/admin"
	"quickstart/models/index"
	"quickstart/pkg/d"
	"strconv"
	"strings"
)

type IndexController struct {
	BaseController
}

func (this *IndexController)Cs() {
	cid := this.Ctx.Input.Param(":id")
	cid2, _ := strconv.Atoi(cid)
	fmt.Println("cid2", cid2)
	//this.Data["json"] = cid2
	//this.ServeJSON()
}

// 首页
func (this *IndexController)Index() {
	this.Data["json"] = copyClassList(0)
	this.fetch()
}
// 栏目页
func (this *IndexController)List() {
	id,_ := this.GetInt("typeid")
	page,_ := this.GetInt("page")
	if page == 0 {
		page = 1
	}
	// 栏目id
	this.Data["id"] = id
	// page 范围，最大页数在typedata中，所以在循环中控制
	if page < 1 {
		page = 1
	}
	// 栏目数据
	typeData := copyClassList(id)
	this.Data["typeData"] = typeData
	// 当前栏目最大页数
	this.Data["total"] = 1
	for _,v := range typeData {
		if id == v.Id {
			this.Data["total"] = v.Total
			if page > v.Total {
				this.Data["page"] = v.Total
				this.Data["next"] = 0
			} else if page == v.Total {
				this.Data["next"] = 0
			} else {
				this.Data["next"] = page+1
			}
		}
	}
	fmt.Println("page = ",page)
	fmt.Println("next = ",this.Data["next"])
	fmt.Println("total = ",this.Data["total"])
	this.Data["page"] = page
	// pre
	this.Data["pre"] = page-1
	if page < 2 {
		this.Data["pre"] = 0
	}

	// 列表数据
	this.Data["list"] = copyList(id,page)
	this.fetch()
}
// 书籍描述页
func (this *IndexController)Book() {
	bookid,_ := this.GetInt("bookid")
	// 书籍描述
	re := copyBookContent(bookid)
	this.Data["data"] = re
	list := copyBooklist(bookid)
	// 开始章节url
	this.Data["startUrl"] = list[0].Id
	// 总章节数
	var lenth = len(list)
	this.Data["total"] = lenth
	// 最新章节
	var newpage = 5
	if lenth < newpage {
		newpage = lenth
	}
	var newlist []ChapterList = make([]ChapterList,newpage)
	for i := 1; i <= newpage; i++ {
		newlist[i-1] = list[lenth - i]
	}
	this.Data["newlist"] = newlist
	this.Data["json"] = list
	this.fetch()
}
// 章节内容页 @bookid 书籍id;  @articleid 文章id
func (this *IndexController)Article() {
	bookid,_ := this.GetInt("bookid")
	articleid,_ := this.GetInt("articleid")
	re := copyBookArticle(bookid,articleid)
	this.Data["data"] = re
	// 书籍内容
	this.Data["book"] = copyBookContent(bookid)
	this.fetch()
}
// 搜索页
func (this *IndexController)Search() {
	keyword := this.GetString("keyword") // 关键字
	page,errpage := this.GetInt("page") // 章节ID

	if errpage != nil {
		page = 1
	}

	re := copySearchBook(keyword,page)
	// 最大页数
	var total int
	if re == nil {
		total = 0
	} else {
		total = re[0].Total
	}
	// 当前页 + 下一页
	next := 0
	if page > total {
		page = total
	} else if page == total {
		next = 0
	} else {
		next = page + 1
	}
	// 上一页
	pre := 0
	if page <= 1 {
		pre = 0
	} else {
		pre = page - 1
	}
	pageData := make(map[string]int)
	pageData["page"] = page
	pageData["pre"] = pre
	pageData["next"] = next
	pageData["total"] = total
	this.Data["pageData"] = pageData
	this.Data["keyword"] = keyword
	this.Data["data"] = re
	this.fetch()
}

var memberModel = new(index.Member)

// 注册
func (this *IndexController) Register() {
	if this.Ctx.Input.IsAjax() {
		// 接收
		username := this.GetString("username")
		password := this.GetString("password")
		email := this.GetString("email")
		// 验证
		if username == "" {
			this.JsonReuturn(0, "用户名不能为空")
		} else {
			re,_ := memberModel.Find(username)
			// 不存在时 err =  record not found
			if re != (index.Member{}) {
				this.JsonReuturn(0, "用户名已存在")
			}
		}
		if password == "" {
			this.JsonReuturn(0, "密码不能为空")
		}
		if email == "" {
			this.JsonReuturn(0, "邮箱不能为空")
		}
		// 保存
		data := index.Member{}
		if err := this.ParseForm(&data); err != nil {
			this.JsonReuturn(0, "赋值失败")
		}
		//fmt.Println("data = ", data)
		code, msg := memberModel.Add(data)
		// 自动登录
		if code == 1 {
			re := index.BookCase{}
			err := admin.Db.First(&re).Error
			if err != nil {
				this.Ctx.SetCookie("member_id", strconv.Itoa(re.Id), 30 * 86000)
				this.Ctx.SetCookie("member_username", data.Username, 30 * 86000)
			}
		}
		this.JsonReuturn(code, msg)
	}
	this.fetch()
}

// 检测登录
func (this *IndexController) IsLogin() {
	member_id := this.Ctx.GetCookie("member_id")
	if this.Ctx.Input.IsAjax(){
		if member_id == "" {
			this.JsonReuturn(0, "未登录")
		}
	} else {
		if member_id == "" {
			this.Redirect("login",302)
		}
	}
}

// 登录
func (this *IndexController) Login() {
	if this.Ctx.Input.IsAjax() {
		// 接收
		username := this.GetString("username")
		password := this.GetString("password")
		// 验证
		if username == "" {
			this.JsonReuturn(0, "用户名不能为空")
		}
		if password == "" {
			this.JsonReuturn(0, "密码不能为空")
		}
		var member index.Member
		err := admin.Db.Where("username = ?",username).Where("password = ?",d.MD5(password)).First(&member).Error
		if err != nil {
			this.JsonReuturn(0, "登录失败，账号或密码错误")
		} else {
			this.Ctx.SetCookie("member_username", username, 30 * 86000)
			this.Ctx.SetCookie("member_id", strconv.Itoa(member.Id), 30 * 86000)
			this.JsonReuturn(1, "登录成功")
		}
	}
	this.fetch()
}

// 退出
func (this *IndexController) LoginOut() {
	this.Ctx.SetCookie("member_id","")
	this.Ctx.SetCookie("member_username","")
	this.Redirect("/",302)
}

// 个人中心，书签页
func (this *IndexController) Member() {
	this.IsLogin()
	uidtmp := this.Ctx.GetCookie("member_id")
	uid,_ := strconv.Atoi(uidtmp)
	re,_ := new(index.BookCase).FindAll(uid)
	this.Data["json"] = re
	this.fetch()
}

// 添加书签
func (this *IndexController) AddBookCase() {
	this.IsLogin()
	if this.Ctx.Input.IsAjax() {
		bookId,_ := this.GetInt("bookId")
		articleId,_ := this.GetInt("articleId")
		articleName := this.GetString("articleName")
		uid := this.Ctx.GetCookie("member_id")
		user_id,_ := strconv.Atoi(uid)
		data := index.BookCase{BookId:bookId,ArticleId:articleId,EndArticleName:articleName,UserId:user_id}

		code,msg := new(index.BookCase).Add(data)
		this.JsonReuturn(code, msg)
	} else {
		this.JsonReuturn(0, "请求类型错误")
	}
}

// 删除书签
func (this *IndexController) DelBookCase() {
	this.IsLogin()
	bookId,_ := this.GetInt("bookId")
	if this.Ctx.Input.IsAjax() {
		uid := this.Ctx.GetCookie("member_id")
		user_id,_ := strconv.Atoi(uid)
		code,msg := new(index.BookCase).Del(bookId,user_id)
		this.JsonReuturn(code, msg)
	} else {
		this.JsonReuturn(0, "请求类型错误")
	}
}


// 结构体

// 栏目
type Classify struct {
	Id int
	Name string
	Total int
}

// 书籍
type Book struct {
	Id int
	Typeid int // 栏目id
	Typename string // 不准确的name
	Name string
	Author string
	Updatatime string // 最后更新时间
	Endcase string // 最后章节名
	EndcaseId int // 最后章id
	Info string // 书籍简介
	Status int // 状态:1=完结;2=连载;3=未知
	Image string // 封面图
}

// 书籍列表
type BookList struct {
	BookId int
	Name string
	Image string
	Author string
	Info string
}

// 书籍章节列表
type ChapterList struct {
	Id int
	BookId int
	Name string
}

// 书籍章节内容页
type BookArticle struct {
	Id int
	BookId int
	Name string
	Body string
	NextId int //下一章节ID
	PreId int //上一章节ID
}

// 书籍搜索
type BookSearch struct {
	SearchId int
	BookId int
	Name string // 书籍名
	Author string // 栏目|作者
	Status string // 状态|最新章节
	Total int // 总页数
}

const copyUrl  = "https://m.qu.la" //http://www.xbiquge.la/SearchBook.php,https://www.qu.la
const copyUrl2  = "https://www.qu.la" //http://www.xbiquge.la/SearchBook.php,
const listUrl  = copyUrl + "/wapsort/0_1.html" //获取栏目分类url
const fwCopyUrl = "m.qu.la" // 采集时，只针对此url
const fwCopyUrl2 = "www.qu.la" // 采集时，只针对此url
const booklist = "/booklist/" //文章章节链接=https://m.qu.la/booklist/3353.html
const bookarticledir = "/book/" //文章章节内容链接=https://www.qu.la/book/3353/10586038.html

// https://m.qu.la/wapsort/0_2.html,  一共 7个栏目
var CopyListUrl = [4]string{"/wapsort/","7","_",".html"}

// 采集
const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
func RandomString() string {
	b := make([]byte, rand.Intn(10)+10)
	for i := range b {
		b[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(b)
}
// trim
func trim(str string) (str2 string) {
	str2 = strings.Replace(str,"\n","",-1)
	str2 = strings.Trim(str2, " ")
	return
}

// 栏目列表
func copyClassList (id int) (re []Classify) {
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		colly.AllowedDomains(fwCopyUrl),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})
	// 获取单本数据地址
	c.OnHTML(".sortChannel_nav a", func(e *colly.HTMLElement) {
		ch := e.DOM
		// id
		href,_ := ch.Attr("href")
		tmpId := strings.Replace(href,"/wapsort/","",1)
		tmpId = strings.Replace(tmpId,"_1.html","",1)
		id,_ := strconv.Atoi(tmpId)
		// name
		name,_ := ch.Html()
		name = trim(name)
		// total
		total := copyListTotal(copyUrl + CopyListUrl[0] + tmpId + CopyListUrl[2] + "1" + CopyListUrl[3])
		re = append(re,Classify{Name:name,Id:id,Total:total})
	})
	c.Visit(copyUrl + CopyListUrl[0] + strconv.Itoa(id) + CopyListUrl[2] + "1" + CopyListUrl[3])
	return
}
func copyListTotal(listUrl string) (total2 int) {
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		colly.AllowedDomains(fwCopyUrl),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})
	// 获取单本数据地址
	c.OnHTML("body", func(e *colly.HTMLElement) {
		ch := e.DOM
		// total
		total,_ := ch.Find("#txtPage").Attr("value")
		total = strings.Replace(total,"1/","",1)
		total2,_ = strconv.Atoi(total)
		return
	})
	c.Visit(listUrl)
	return
}

// 书籍列表，page默认=1，limit只能是10  @typeid 分类ID; @page 分页，默认=1
func copyList(typeid,page int) (re []BookList) {
	weburl := copyUrl+CopyListUrl[0]+strconv.Itoa(typeid)+CopyListUrl[2]+strconv.Itoa(page)+CopyListUrl[3]
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		colly.AllowedDomains(fwCopyUrl),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})

	// 获取单本数据地址
	c.OnHTML("#main .hot_sale", func(e *colly.HTMLElement) {
		ch := e.DOM
		// id
		href,_ := ch.Find("a").Attr("href")
		tmpId := strings.Replace(href,"/book/","",1)
		tmpId = strings.Replace(tmpId,"/","",-1)
		id,_ := strconv.Atoi(tmpId)
		// Name
		name,_ := ch.Find(".title").Html()
		name = trim(name)
		// Author
		author,_ := ch.Find(".author").Html()
		author = trim(author)
		author = strings.Replace(author,"作者：","",1)
		// info
		info,_ := ch.Find(".review").Html()
		info = trim(info)
		info = strings.Replace(info,"<span class=\"longview\"><svg class=\"lnr lnr-chevron-down-circle\"><use xlink:href=\"#lnr-chevron-down-circle\"></use></svg></span>", "",1 )
		// image
		image,errImage := ch.Find("a img").Attr("data-original")
		if errImage != true {
			image = copyUrl + "/images/nopic.gif"
		}
		re = append(re,BookList{Name:name,BookId:id,Image:image,Author:author,Info:info})
	})
	c.Visit(weburl)
	return
}

// 书籍介绍页 @bookid 书籍ID;
func copyBookContent(id int) (re Book) {
	weburl := copyUrl + "/book/" + strconv.Itoa(id) + "/"

	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		colly.AllowedDomains(fwCopyUrl),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})

	// 获取单本数据地址
	c.OnHTML("html", func(e *colly.HTMLElement) {
		ch := e.DOM
		// 书名
		name, _ := ch.Find("meta[property='og:novel:book_name']").Attr("content")
		// 作者
		author,_ := ch.Find("meta[property='og:novel:author']").Attr("content")
		// 最后更新时间
		updatetime,_ := ch.Find("meta[property='og:novel:update_time']").Attr("content")
		// 最后章节
		endcase,_ := ch.Find("meta[property='og:novel:latest_chapter_name']").Attr("content")
		// 最后章节ID
		endcaseIdTmp,_ := ch.Find("meta[property='og:novel:latest_chapter_url']").Attr("content")
		start := strings.LastIndex(endcaseIdTmp,"/")+1
		end := strings.LastIndex(endcaseIdTmp,".")
		endcaseIdTmp = endcaseIdTmp[start:end]
		endcaseId,_ := strconv.Atoi(endcaseIdTmp)
		// 小说简介
		info,_ := ch.Find("meta[property='og:description']").Attr("content")
		// 封面图片
		image,_ := ch.Find("meta[property='og:image']").Attr("content")
		// 连载状态
		statusTmp,_ := ch.Find("meta[property='og:novel:status']").Attr("content")
		var status int
		if statusTmp == "连载" {
			status = 2
		} else if statusTmp == "完成" {
			status = 1
		}else {
			status = 3
		}
		// 栏目id
		typename,_ := ch.Find("meta[property='og:novel:category']").Attr("content")
		typelist := []string{"全部","玄幻奇幻","武侠仙侠","都市言情","历史军事","科幻灵异","网游竞技","女生频道"}
		typeid := 0
		for i := 0; i < len(typelist); i++ {
			if typelist[i] == typename {
				typeid = i
			}
		}
		re = Book{Id:id,Name:name,Image:image,Author:author,Info:info,Status:status,Endcase:endcase,EndcaseId:endcaseId,Updatatime:updatetime,Typeid:typeid,Typename:typename}
	})

	c.Visit(weburl)
	return
}

// 书籍章节列表 @bookid 书籍ID;
func copyBooklist(bookid int) (re []ChapterList) {
	weburl := copyUrl + booklist + strconv.Itoa(bookid) + ".html"

	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		colly.AllowedDomains(fwCopyUrl),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})

	// 获取单本数据地址
	c.OnHTML("#chapterlist p:nth-of-type(n+2)", func(e *colly.HTMLElement) {
		ch := e.DOM
		// 章节ID
		id, _ := ch.Find("a").Attr("href")
		id = strings.Replace(id,"/book/"+strconv.Itoa(bookid)+"/","",1)
		id = strings.Replace(id,".html","",1)
		chapterId,_ := strconv.Atoi(id)
		// 章节名
		name, _ := ch.Find("a").Html()
		name = "<a href='/article?bookid="+strconv.Itoa(bookid)+"&articleid="+id+"'>"+name+"</a>"
		re = append(re,ChapterList{Id:chapterId,BookId:bookid,Name:name})
	})

	c.Visit(weburl)
	return
}

// 书籍章节内容页 @bookid 书籍ID;  @articleid  章节ID;
func copyBookArticle(bookid,articleid int) (re BookArticle) {
	weburl := copyUrl2 + bookarticledir + strconv.Itoa(bookid) + "/" + strconv.Itoa(articleid) + ".html"
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		colly.AllowedDomains(fwCopyUrl, fwCopyUrl2),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})
	// 获取单本数据地址
	c.OnHTML(".content_read .box_con", func(e *colly.HTMLElement) {
		ch := e.DOM
		// 章节名
		name, _ := ch.Find(".bookname h1").Html()
		// 上一章ID
		preid,_ := ch.Find(".bookname .bottem1 #pager_prev").Attr("href")
		preid = strings.Replace(preid,".html","",1)
		preid2,_ := strconv.Atoi(preid)
		// 下一章ID
		naxtid,_ := ch.Find(".bookname .bottem1 #pager_next").Attr("href")
		naxtid = strings.Replace(naxtid,".html","",1)
		naxtid2,_ := strconv.Atoi(naxtid)
		// 章节ID
		body, _ := ch.Find("#content").Html()
		body = strings.Replace(body,"<script>chaptererror();</script>","",1)
		re = BookArticle{Id:articleid,BookId:bookid,Name:name,Body:body,PreId:preid2,NextId:naxtid2}
	})
	c.Visit(weburl)
	return
}

// 获取搜索数据 @keyword 关键字;  @page 分页，默认=1
func copySearchBook(keyword string, page int) (re []BookSearch) {
	weburl := "https://sou.xanbhx.com/search?siteid=qula&t=m&q="+keyword+"&page=" + strconv.Itoa(page)


	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		colly.AllowedDomains(),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})
	c.WithTransport(&http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	})
	// 获取单本数据地址
	c.OnHTML(".mybook .hot_sale", func(e *colly.HTMLElement) {
		ch := e.DOM
		// id
		searchid, _ := ch.Find("span").Html()
		searchid = trim(searchid)
		searchid2,_ := strconv.Atoi(searchid)
		// bookid
		bookid, _ := ch.Find("a").Attr("href")
		bookid = strings.Replace(bookid,"https://m.qu.la/book/","",1)
		bookid = strings.Replace(bookid,"/","",1)
		bookid2,_ := strconv.Atoi(bookid)
		// 书籍名
		name, _ := ch.Find("p.title").Html()
		name = trim(name)
		// 栏目|作者
		author,_ := ch.Find("p:nth-child(2)").Html()
		author = trim(author)
		// 状态|最新章节
		status,_ := ch.Find("p:nth-child(3)").Html()
		status = trim(status)
		// 总共total
		total := copySearchBookTotal(weburl)
		//
		re = append(re,BookSearch{SearchId:searchid2,BookId:bookid2,Name:name,Author:author,Total:total,Status:status})
	})
	c.Visit(weburl)
	return
}
func copySearchBookTotal(weburl string) (total int) {
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		colly.AllowedDomains(),
	)
	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})
	// 获取单本数据地址
	c.OnHTML(".mybook", func(e *colly.HTMLElement) {
		ch := e.DOM
		// total
		totaltmp, _ := ch.Find("#txtPage").Attr("value")
		totaltmp = totaltmp[strings.Index(totaltmp,"/")+1:]
		total2,_ := strconv.Atoi(totaltmp)
		total = total2
	})
	c.Visit(weburl)
	return
}