package admin

import (
	"fmt"
	"github.com/astaxie/beego/validation"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/debug"
	"log"
	"math/rand"
	"strconv"
	"strings"
	"time"
)

type Book struct {
	Id int
	Typeid int
	Name string
	Author string
	Updatatime string
	Endcase string
	Info string
	Status int
	Click int
	Collect int
	Addtime int64
	Image string
	CopyId int
}

// 查询
type BookWhere struct{
	Typeid int
	Name string
	Author string
	Status int
}

// 如果你的 struct 实现了接口 validation.ValidFormer
// 当 StructTag 中的测试都成功时，将会执行 Valid 函数进行自定义验证
func (this Book) Valid(v *validation.Validation) {
	if this.Typeid == 0 {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("栏目ID", "不能为空")
	}
	if this.Name == "" {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("书名", "不能为空")
	}
}

// 列表
func (this Book) FindAll(where BookWhere) (re []Book,count int) {
	var query string = ""
	if where.Typeid != 0 {
		query += " AND typeid = "+ strconv.Itoa(where.Typeid)
	}
	if where.Name != "" {
		query += " AND name like '%"+ where.Name + "'%"
	}
	if where.Author != "" {
		query += " AND author like '%"+ where.Author + "'%"
	}
	err := Db.Where(query).Find(&re).Error
	if err != nil {
		log.Println(err)
	}
	Db.Model(this).Where(query).Count(&count)
	return
}

// 查询
func (this *Book) Find(id int) (re Type, err error) {
	err = Db.First(&re, id).Error
	return
}

// status 设置
func (this *Book) SetStatus(id, status int) (code int, msg string) {
	err := Db.Model(this).Where("id = ?", id).Update("is_navi", status).Error
	if err != nil {
		code = 0
		msg = "设置状态失败"
	} else {
		code = 1
		msg = "设置成功"
	}
	return
}

// 修改
func (this *Book) Save(data Book) (code int, msg string) {
	if data.Id == 0 {
		code = 0
		msg = "未定义主键"
		return
	}
	// 数据验证
	valid := validation.Validation{}
	b, validErr := valid.Valid(&data)
	if validErr != nil {
		fmt.Println("validErr = ", validErr)
	}
	if !b {
		for _, err := range valid.Errors {
			code = 0
			msg = err.Key + " " + err.Message
			return
		}
	}
	// 修改
	err := Db.Model(this).Where("id=?",data.Id).Updates(data).Error
	if err != nil {
		code = 0
		msg = "修改失败"
	} else {
		code = 1
		msg = "修改成功成功"
	}
	return
}

// 添加
func (this *Book) Add(data Book) (code int, msg string) {
	// 数据验证
	valid := validation.Validation{}
	b, validErr := valid.Valid(&data)
	if validErr != nil {
		fmt.Println("validErr = ", validErr)
	}
	if !b {
		for _, err := range valid.Errors {
			code = 0
			msg = err.Key + " " + err.Message
			return
		}
	}
	data.Addtime = time.Now().Unix()
	err := Db.Model(this).Create(&data).Error
	if err != nil {
		code = 0
		msg = "添加失败"
	} else {
		code = 1
		msg = "添加成功"
	}
	return
}

// 删除
func (this *Book) AjaxDel(id int) (code int, msg string) {
	err := Db.Where("id = ?", id).Delete(this).Error
	if err != nil {
		code = 0
		msg = "删除失败"
	} else {
		code = 1
		msg = "删除成功"
	}
	return
}

// 批量删除
func (this *Book) AjaxDelAll(ids string) (code int, msg string) {
	err := Db.Debug().Where("id In ("+ids+")").Delete(this).Error
	if err != nil {
		code = 0
		msg = "删除失败"
	} else {
		code = 1
		msg = "删除成功"
	}
	return
}


// 采集
const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func RandomString() string {
	b := make([]byte, rand.Intn(10)+10)
	for i := range b {
		b[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(b)
}

func (this *Book) SearchBook(weburl string) (re Book) {
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		//colly.AllowedDomains("www.feihuaba.com", "feihuaba.com"),
	)

	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})

	// 获取单本数据地址
	c.OnHTML(".search-list ul", func(e *colly.HTMLElement) {
		ch := e.DOM
		ch = ch.Find("li:nth-of-type(2) .s2 a")
		url,_ := ch.Attr("href")
		fmt.Println("url = ", url)
		//re = GetBookInfo(url)
	})
	c.Visit(weburl)
	return
}

func GetBookInfo(weburl string) (re Book) {
	c := colly.NewCollector(
		colly.Debugger(&debug.LogDebugger{}),
		// 只访问域名
		//colly.AllowedDomains("www.feihuaba.com", "feihuaba.com"),
	)

	// User-Agent
	c.OnRequest(func(r *colly.Request) {
		r.Headers.Set("User-Agent", RandomString())
	})

	// 获取单本数据地址
	c.OnHTML("html", func(e *colly.HTMLElement) {
		ch := e.DOM
		fmt.Println(ch.Find("meta[property='og:title']").Attr("content"))

		// 书名
		name, _ := ch.Find("meta[property='og:title']").Attr("content")
		// 作者
		author,_ := ch.Find("meta[property='og:novel:author']").Attr("content")
		fmt.Println("author = ", author)
		// 最后更新时间
		updatetime,_ := ch.Find("meta[property='og:novel:update_time']").Attr("content")
		fmt.Println("updatetime = ", updatetime)
		// 最后章节
		endcase,_ := ch.Find("meta[property='og:novel:latest_chapter_name']").Attr("content")
		// 小说简介
		info,_ := ch.Find("meta[property='og:description']").Attr("content")
		// 采集书籍ID
		copyid,_ := ch.Find("meta[property='og:url']").Attr("content")
		fmt.Println("copyid = ", copyid)
		copyid = strings.Replace(copyid,"https://www.qu.la/book/","",1)
		copyid = strings.Replace(copyid,"/","",1)
		// 封面图片
		re.Image,_ = ch.Find("meta[property='og:image']").Attr("content")
		// 连载状态
		statusTmp,_ := ch.Find("meta[property='og:novel:status']").Attr("content")
		var Status2 int
		if statusTmp == "连载" {
			Status2 = 2
		} else if statusTmp == "完成" {
			Status2 = 1
		}else {
			Status2 = 3
		}
		re.Name = name
		re.Author = author
		re.Updatatime = updatetime
		re.Endcase = endcase
		re.Info = info
		re.Status = Status2
		re.CopyId,_ = strconv.Atoi(copyid)
		//fmt.Println("book = ", re)

	})
	c.Visit(weburl)
	return
}