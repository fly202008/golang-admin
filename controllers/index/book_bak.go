package index
//
//import (
//	"fmt"
//	"github.com/gocolly/colly"
//	"github.com/gocolly/colly/debug"
//	"math/rand"
//	"strconv"
//	"strings"
//)
//
//type BookController struct {
//	BaseController
//}
//
//// 栏目
//type Classify struct {
//	Id int
//	Name string
//}
//
//// 书籍
//type Book struct {
//	Id int
//	Typeid int // 栏目id
//	Name string
//	Author string
//	Updatatime string // 最后更新时间
//	Endcase string // 最后章节名
//	EndcaseId int // 最后章id
//	Info string // 书籍简介
//	Status int // 状态:1=完结;2=连载;3=未知
//	Image string // 封面图
//}
//
//// 书籍列表
//type BookList struct {
//	BookId int
//	Name string
//	Image string
//	Author string
//	Info string
//}
//
//// 书籍章节列表
//type ChapterList struct {
//	Id int
//	BookId int
//	Name string
//}
//
//// 书籍章节内容页
//type BookArticle struct {
//	Id int
//	BookId int
//	Name string
//	Body string
//	LastId int
//	PreId int
//}
//
//// 查询
//type BookWhere struct{
//	Typeid int
//	Name string
//	Author string
//	Status int
//}
//
//const copyUrl  = "https://m.qu.la" //http://www.xbiquge.la/SearchBook.php
//const listUrl  = copyUrl + "/wapsort/0_1.html" //获取栏目分类url
//const fwCopyUrl = "m.qu.la" // 采集时，只针对此url
//const booklist = "/booklist/" //文章章节链接=https://m.qu.la/booklist/3353.html
//
//// https://m.qu.la/wapsort/0_2.html,  一共 7个栏目
//var CopyListUrl [4]string = [4]string{"/wapsort/","7","_",".html"}
//
//// 采集
//const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
//func RandomString() string {
//	b := make([]byte, rand.Intn(10)+10)
//	for i := range b {
//		b[i] = letterBytes[rand.Intn(len(letterBytes))]
//	}
//	return string(b)
//}
//// trim
//func trim(str string) (str2 string) {
//	str2 = strings.Replace(str,"\n","",-1)
//	str2 = strings.Trim(str2, " ")
//	return
//}
//
//// 栏目列表
//func (this *BaseController)ClassList() {
//	re := copyClassList()
//	this.Data["json"] = re
//	this.ServeJSON()
//}
//func copyClassList () (re []Classify) {
//	c := colly.NewCollector(
//		colly.Debugger(&debug.LogDebugger{}),
//		// 只访问域名
//		colly.AllowedDomains(fwCopyUrl),
//	)
//
//	// User-Agent
//	c.OnRequest(func(r *colly.Request) {
//		r.Headers.Set("User-Agent", RandomString())
//	})
//
//	// 获取单本数据地址
//	c.OnHTML(".sortChannel_nav a", func(e *colly.HTMLElement) {
//		ch := e.DOM
//		// id
//		href,_ := ch.Attr("href")
//		fmt.Println("ch = ",href)
//
//		tmpId := strings.Replace(href,"/wapsort/","",1)
//		tmpId = strings.Replace(tmpId,"_1.html","",1)
//		id,_ := strconv.Atoi(tmpId)
//		// name
//		name,_ := ch.Html()
//		name = trim(name)
//		re = append(re,Classify{Name:name,Id:id})
//	})
//	c.Visit(listUrl)
//	return
//}
//
//// 书籍列表，page默认=1，limit只能是10
//func (this *BookController)List() {
//	typeid,err := this.GetInt("typeid")
//	if err != nil {
//		this.JsonReuturn(0,"请求参数错误")
//	}
//	// 默认参数
//	page,_ := this.GetInt("page")
//	if page == 0 {
//		page = 1
//	}
//	limit,_ := this.GetInt("limit")
//	if limit == 0 {
//		limit = 1
//	}
//	weburl := copyUrl+CopyListUrl[0]+strconv.Itoa(typeid)+CopyListUrl[2]+strconv.Itoa(page)+CopyListUrl[3]
//	fmt.Println(weburl)
//	re := copyList(weburl)
//	this.JsonReuturn(1,"200", re)
//}
//func copyList(weburl string) (re []BookList) {
//	c := colly.NewCollector(
//		colly.Debugger(&debug.LogDebugger{}),
//		// 只访问域名
//		colly.AllowedDomains(fwCopyUrl),
//	)
//	// User-Agent
//	c.OnRequest(func(r *colly.Request) {
//		r.Headers.Set("User-Agent", RandomString())
//	})
//
//	// 获取单本数据地址
//	c.OnHTML("#main .hot_sale", func(e *colly.HTMLElement) {
//		ch := e.DOM
//		// id
//		href,_ := ch.Find("a").Attr("href")
//		tmpId := strings.Replace(href,"/book/","",1)
//		tmpId = strings.Replace(tmpId,"/","",-1)
//		id,_ := strconv.Atoi(tmpId)
//		// Name
//		name,_ := ch.Find(".title").Html()
//		name = trim(name)
//		// Author
//		author,_ := ch.Find(".author").Html()
//		author = trim(author)
//		author = strings.Replace(author,"作者：","",1)
//		// info
//		info,_ := ch.Find(".review").Html()
//		info = trim(info)
//		info = strings.Replace(info,"<span class=\"longview\"><svg class=\"lnr lnr-chevron-down-circle\"><use xlink:href=\"#lnr-chevron-down-circle\"></use></svg></span>", "",1 )
//		// image
//		image,errImage := ch.Find("a img").Attr("data-original")
//		if errImage != true {
//			image = copyUrl + "/images/nopic.gif"
//		}
//		re = append(re,BookList{Name:name,BookId:id,Image:image,Author:author,Info:info})
//	})
//	c.Visit(weburl)
//	return
//}
//
//// 书籍介绍页
//func (this *BookController)Show() {
//	id,errId := this.GetInt("id")
//	if errId != nil {
//		this.JsonReuturn(0,"请求参数错误")
//	}
//	// https://m.qu.la/book/194791/
//	re := copyBookContent(id)
//	this.JsonReuturn(1,"ok", re)
//}
//func copyBookContent(id int) (re Book) {
//	weburl := copyUrl + "/book/" + strconv.Itoa(id) + "/"
//
//	c := colly.NewCollector(
//		colly.Debugger(&debug.LogDebugger{}),
//		// 只访问域名
//		colly.AllowedDomains(fwCopyUrl),
//	)
//	// User-Agent
//	c.OnRequest(func(r *colly.Request) {
//		r.Headers.Set("User-Agent", RandomString())
//	})
//
//	// 获取单本数据地址
//	c.OnHTML("html", func(e *colly.HTMLElement) {
//		ch := e.DOM
//		// 书名
//		name, _ := ch.Find("meta[property='og:novel:book_name']").Attr("content")
//		// 作者
//		author,_ := ch.Find("meta[property='og:novel:author']").Attr("content")
//		// 最后更新时间
//		updatetime,_ := ch.Find("meta[property='og:novel:update_time']").Attr("content")
//		// 最后章节
//		endcase,_ := ch.Find("meta[property='og:novel:latest_chapter_name']").Attr("content")
//		// 最后章节ID
//		endcaseIdTmp,_ := ch.Find("meta[property='og:novel:latest_chapter_url']").Attr("content")
//		start := strings.LastIndex(endcaseIdTmp,"/")+1
//		end := strings.LastIndex(endcaseIdTmp,".")
//		endcaseIdTmp = endcaseIdTmp[start:end]
//		endcaseId,_ := strconv.Atoi(endcaseIdTmp)
//		// 小说简介
//		info,_ := ch.Find("meta[property='og:description']").Attr("content")
//		// 封面图片
//		image,_ := ch.Find("meta[property='og:image']").Attr("content")
//		// 连载状态
//		statusTmp,_ := ch.Find("meta[property='og:novel:status']").Attr("content")
//		var status int
//		if statusTmp == "连载" {
//			status = 2
//		} else if statusTmp == "完成" {
//			status = 1
//		}else {
//			status = 3
//		}
//		re = Book{Id:id,Name:name,Image:image,Author:author,Info:info,Status:status,Endcase:endcase,EndcaseId:endcaseId,Updatatime:updatetime}
//	})
//
//	c.Visit(weburl)
//	return
//}
//
//// 书籍章节列表
//func (this *BookController)Chapter() {
//	id,errId := this.GetInt("id") // 书籍ID
//	if errId != nil {
//		this.JsonReuturn(0,"请求参数错误")
//	}
//	re := copyBooklist(id)
//	this.JsonReuturn(1,"ok", re)
//}
//func copyBooklist(bookid int) (re []ChapterList) {
//	weburl := copyUrl + booklist + strconv.Itoa(bookid) + ".html"
//
//	c := colly.NewCollector(
//		colly.Debugger(&debug.LogDebugger{}),
//		// 只访问域名
//		colly.AllowedDomains(fwCopyUrl),
//	)
//	// User-Agent
//	c.OnRequest(func(r *colly.Request) {
//		r.Headers.Set("User-Agent", RandomString())
//	})
//
//	// 获取单本数据地址
//	c.OnHTML("#chapterlist p:nth-of-type(n+2)", func(e *colly.HTMLElement) {
//		ch := e.DOM
//		// 章节名
//		name, _ := ch.Find("a").Html()
//		fmt.Println("name = ",name)
//		// 章节ID
//		id, _ := ch.Find("a").Attr("href")
//		id = strings.Replace(id,"/book/"+strconv.Itoa(bookid)+"/","",1)
//		id = strings.Replace(id,".html","",1)
//		chapterId,_ := strconv.Atoi(id)
//		fmt.Println("id = ",id)
//		re = append(re,ChapterList{Id:chapterId,BookId:bookid,Name:name})
//	})
//
//	c.Visit(weburl)
//	return
//}
//
//// 书籍章节内容页
//func (this *BookController)Article() () {
//
//}