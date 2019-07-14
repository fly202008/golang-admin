package index

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"quickstart/pkg/d"
	"time"
)

var (
	Db *gorm.DB
)

type Member struct {
	Id uint `gorm:"primary_key"`
	Username string
	Password string
	Email string
	Addtime int64
}

func (this Member) Add(data Member) (code int, msg string) {
	data.Addtime = time.Now().Unix()
	data.Password = d.MD5(data.Password)
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

func (this Member) Find(name string) (re Member,err error) {
	fmt.Println("+++")
	fmt.Println("name = ", name)
	err = Db.Model(this).First(&re,1).Error
	//err = Db.Model(this).Where("username = '?'",name).First(&re).Error
	fmt.Println("err = ", err)
	fmt.Println("re = ", re)
	return
}