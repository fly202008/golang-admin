package admin

import (
	"log"
)

type User struct {
	Model
	Username string `rom:"size(32)"`
	Password	string	`rom:"size(32)"`
	Status uint
	Last_login_time int64
}

func (m *User) FindAll() (re []User) {
	err := Db.Find(&re).Error
	if err != nil {
		log.Println(err)
	}
	return
}

//func (m *User) FindAll() (configs []User, err error) {
//	err = Db.Find(&configs).Error
//	return
//}
