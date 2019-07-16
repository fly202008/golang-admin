package index

import (
	"quickstart/models/admin"
	"quickstart/pkg/d"
	"time"
)

//var (
//	Db *gorm.DB
//)

type Member struct {
	Id int `gorm:"primary_key"  json:"id" form:"id"`
	Username string `json:"username" form:"username"`
	Password string `json:"password" form:"password"`
	Email string `json:"email" form:"email"`
	Addtime int64 `json:"addtime" form:"addtime"`
}

func (this *Member) Add(data Member) (code int, msg string) {
	data.Addtime = time.Now().Unix()
	data.Password = d.MD5(data.Password)
	err := admin.Db.Create(&data).Error
	if err != nil {
		code = 0
		msg = "注册失败"
	} else {
		code = 1
		msg = "注册成功"
	}
	return
}

func (this *Member) Find(name string) (re Member,err error) {
	err = admin.Db.Debug().Where("username = ?",name).First(&re).Error
	return
}