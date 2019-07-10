package copy

import (
	"fmt"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/debug"
	"math/rand"
)

type Book struct {
	Typeid int
	Name string
	Author string
	Updatatime string
	Endcase string
	Info string
	Status int
	Addtime int64
	Click int
	Collect int
}

const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func RandomString() string {
	b := make([]byte, rand.Intn(10)+10)
	for i := range b {
		b[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(b)
}


func SearchBook(weburl string) (re []Book)  {
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
	c.OnHTML(".search-list ul li:nth-child(2) .s2 a", func(e *colly.HTMLElement) {
		ch := e.DOM
		url,_ := ch.Attr("href")
		fmt.Println("url = ", url)
		re = GetBookInfo(url)
	})
	c.Visit(weburl)
	return
}

func GetBookInfo(weburl string) (re []Book) {
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

		re = append(re,Book{Name:name,Author:author,Updatatime:updatetime,Endcase:endcase,Info:info,Status:Status2})

		//fmt.Println("book = ", re)

	})
	c.Visit(weburl)
	return
}