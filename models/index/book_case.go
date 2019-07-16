package index

import (
	"fmt"
	"github.com/astaxie/beego/validation"
	"quickstart/models/admin"
	"time"
)

type BookCase struct {
	Id int
	BookId int
	ArticleId int
	UserId int
	Addtime int64
	EndArticleName string
}

// 如果你的 struct 实现了接口 validation.ValidFormer
// 当 StructTag 中的测试都成功时，将会执行 Valid 函数进行自定义验证
func (this *BookCase) Valid(v *validation.Validation) {
	if this.BookId == 0 {
		v.SetError("书籍", "未找到")
	}
	// 书本直接加入书架穿 -1 过来
	if this.ArticleId != -1 {
		if this.EndArticleName == "" {
			v.SetError("章节名称", "未找到")
		}
		if this.ArticleId == 0 {
			v.SetError("章节", "未找到")
		}
	}

}

// 添加书签
func (this *BookCase) Add(data BookCase) (code int, msg string) {
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
	// 最多二十本书
	count := 0
	admin.Db.Where("user_id = ?",data.UserId).Find(&this).Count(&count)
	if count > 20 {
		code = 0
		msg = "书籍要爆炸了"
		return
	}
	data.Addtime = time.Now().Unix()

	// 去重
	re := BookCase{}
	admin.Db.Where("book_id = ?",data.BookId).Where("user_id = ?",data.UserId).First(&re)
	if re != (BookCase{}) {
		err := admin.Db.Model(this).Debug().Where("id = ?",re.Id).Updates(&data).Error
		if err != nil {
			code = 0
			msg = "添加失败"
		} else {
			code = 1
			msg = "修改标签成功"
		}
		return
	} else {
		err := admin.Db.Model(this).Create(&data).Error
		if err != nil {
			code = 0
			msg = "添加失败"
		} else {
			code = 1
			msg = "添加成功"
		}
		return
	}
}

// 查询书签
func (this *BookCase) FindAll(uid int) (re []BookCase, err error) {
	err = admin.Db.Where("user_id = ?", uid).Find(&re).Error
	return
}

// 删除
func (this *BookCase) Del(id int,uid int) (code int, msg string) {
	err := admin.Db.Where("id = ?", id).Where("user_id = ?", uid).Delete(this).Error
	if err != nil {
		code = 0
		msg = "删除失败"
	} else {
		code = 1
		msg = "删除成功"
	}
	return
}