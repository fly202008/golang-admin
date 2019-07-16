package admin

import (
	"fmt"
	"github.com/astaxie/beego/validation"
	"log"
	"quickstart/pkg/d"
	"strconv"
	"strings"
	"time"
)

type User struct {
	Model
	Username string `grom:"size(32)"`
	Password	string	`grom:"size(32)"`
	Salt string
	Status int
	Last_login_time int64
}

// 查询
type UserWhere struct{
	Status int
	Username string
	Time1	string
	Time2	string
}

// 如果你的 struct 实现了接口 validation.ValidFormer
// 当 StructTag 中的测试都成功时，将会执行 Valid 函数进行自定义验证
func (this *User) Valid(v *validation.Validation) {
	if this.Id == 0 && this.Username == "" {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("用户名", "不能为空")
	}
	if strings.Index(this.Username, "admin") != -1 {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("Username", "名称里不能含有 admin")
	}
	if this.Id == 0 {
		if this.Password == "" {
			v.SetError("Password", "密码不能为空")
		}
	}
}

// 数据列表
func (this *User) FindAll(page,limit int, where UserWhere) (re []User, count int) {
	var query string = ""
	if where.Status != 0 {
		query += " AND status = "+ strconv.Itoa(where.Status)
	}
	if where.Username != "" {
		query += " AND username like '%"+ where.Username + "%'"
	}
	if where.Time1 != "" {
		query += " AND addtime >="+ strconv.FormatInt(d.Strtotiom(where.Time1),10)
	}
	if where.Time2 != "" {
		query += " AND addtime <"+ strconv.FormatInt(d.Strtotiom(where.Time2),10)
	}
	if query != "" {
		query = strings.Replace(query, " AND", "", 1)
	}

	err := Db.Where(query).Offset(page).Limit(limit).Find(&re).Error

	if err != nil {
		log.Println(err)
	}
	Db.Model(this).Where(query).Count(&count)
	return
}

// status 设置
func (this *User) SetStatus(id, status int) (code int, msg string) {
	//fmt.Printf("id = %d, status = %d\r", id, status)
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
			log.Println(err.Key, err.Message)
			fmt.Println("err.Key = ", err.Key)
			fmt.Println("err.Message = ", err.Message)
			code = 0
			msg = err.Key + " " + err.Message
			return
		}
	}

	//fmt.Printf("M data.Id = %d, data.Status = %d,  data.Password = %v\r", data.Id, data.Status, data.Password)
	if data.Password != "" {
		data.Password = d.MD5(data.Password)
	}
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
func (this *User) Add(data User) (code int, msg string) {
	// 数据验证
	valid := validation.Validation{}
	b, validErr := valid.Valid(&data)
	if validErr != nil {
		fmt.Println("validErr = ", validErr)
	}
	if !b {
		for _, err := range valid.Errors {
			log.Println(err.Key, err.Message)
			fmt.Println("err.Key = ", err.Key)
			fmt.Println("err.Message = ", err.Message)
			code = 0
			msg = err.Key + " " + err.Message
			return
		}
	}

	data.Addtime = time.Now().Unix()
	data.Last_login_time = 0
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
func (this *User) AjaxDel(id int) (code int, msg string) {
	if id == 1 {
		code = 0
		msg = "admin用户不允许删除"
		return
	}
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
func (this *User) AjaxDelAll(ids string) (code int, msg string) {
	a := strings.Index(","+ids+",",",5,")
	fmt.Println("a = ", a)
	if a != -1 {
		code = 0
		msg = "admin用户不允许删除"
		return
	}
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