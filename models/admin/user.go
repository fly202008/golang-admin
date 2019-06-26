package admin

import (
	"fmt"
	"log"
)

type User struct {
	Model
	Username string `rom:"size(32)"`
	Password	string	`rom:"size(32)"`
	Status int
	Last_login_time int64
}

// 数据列表
func (this *User) FindAll(page,limit int) (re []User, count int) {
	err := Db.Offset(page).Limit(limit).Find(&re).Error
	if err != nil {
		log.Println(err)
	}
	Db.Model(User{}).Count(&count)
	return
}

// status 设置
func (this *User) SetStatus(id, status int) (code int, msg string) {
	fmt.Printf("id = %d, status = %d\r", id, status)

	err := Db.Model(this).Where("id = ?", id).Update("status", status).Error
	if err != nil {
		code = 0
		msg = "设置状态失败"
	} else {
		code = 1
		msg = "设置成功"
	}
	return
}

// 查询
func (this *User) Find(id int) (re User, err error) {
	err = Db.First(&re, id).Error
	return
}

// 修改
func (this *User) Save(data User) (code int, msg string) {
	err := Db.Model(this).Where("id=?",this.Id).Updates(data).Error
	if err != nil {
		code = 0
		msg = "修改失败失败"
	} else {
		code = 1
		msg = "修改成功成功"
	}
	return
}