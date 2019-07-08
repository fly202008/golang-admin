package admin

import (
	"fmt"
	"github.com/astaxie/beego/validation"
	"log"
	"strconv"
	"time"
)

type Type struct {
	Id 	int
	Name string 	`grom:"size(32)"`
	Is_navi 	int
	Parent_id int
	Icon string
	Tmp string
	Weight 	int
	Addtime int64
}
type TypeList struct {
	Id 	int
	Name string 	`grom:"size(32)"`
	Is_navi 	int
	Parent_id int
	Icon string
	Tmp string
	Weight 	int
	Addtime int64
	Childern []*TypeList
}

// 查询
type TypeWhere struct{
	Is_navi int
	Name string
}

// 如果你的 struct 实现了接口 validation.ValidFormer
// 当 StructTag 中的测试都成功时，将会执行 Valid 函数进行自定义验证
func (this Type) Valid(v *validation.Validation) {
	if this.Name == "" {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("栏目名", "不能为空")
	}
	if this.Tmp == "" {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("模板", "不能为空")
	}
}

// 列表
func (this Type) FindAll(where TypeWhere) (re []Type, count int) {
	var query string = ""
	if where.Is_navi != 0 {
		query += " AND is_navi = "+ strconv.Itoa(where.Is_navi)
	}
	if where.Name != "" {
		query += " AND name like '%"+ where.Name + "'%"
	}
	err := Db.Where(query).Find(&re).Error
	if err != nil {
		log.Println(err)
	}
	Db.Model(this).Where(query).Count(&count)
	return
}

// 栏目tree
func (this Type) DataTree() (re []*TypeList) {
	//err := Db.Order("weight desc, id").Find(&re).Error
	//if err != nil {
	//	log.Println(err)
	//} else {
	//	this.SetTree(re)
	//	fmt.Println("re = ", re)
	//}
	fmt.Println("1111111111")
	re = this.SetTree(0)
	fmt.Println("re = ", re)
	return
}
// 设置栏目tree
func (this Type) SetTree(pid int) ([]*TypeList) {
	var data []Type
	err := Db.Order("weight desc, id").Find(&data).Error
	if err != nil {
		log.Println(err)
	} else {

	}
	fmt.Println("2222222222")

	typeList := []*TypeList{}
	for _,v := range data {
		child := v.SetTree(v.Id)
		node := &TypeList{
			Id:v.Id,
			Name:v.Name,
			Is_navi:v.Is_navi,
			Parent_id:v.Parent_id,
			Icon:v.Icon,
			Tmp:v.Tmp,
			Weight:v.Weight,
			Addtime:v.Addtime,
		}
		node.Childern = child
		typeList = append(typeList, node)
		fmt.Println("v = ",v)
	}
	return typeList
	//return this.sortTree(data2)
}
// 排序
func (this Type) sortTree(data []Type) (re []Type) {
	//var data2 []Type
	for _,v := range data {
		fmt.Println(v)
		//fmt.Println(data[v.Parent_id])
		//判断是否为顶级权限
		//if data[v.Parent_id] {
		//
		//}
		//if(isset($items[$item['parent_id']])){
		//// 判断当前数据是否为顶级，
		////不是顶级就放在它【复制一份】到上级分类的数据里面，
		////这就是为什么用 & 的原因
		//$items[$item['parent_id']]['son'][] = &$items[$item['pid']];
		//}else{
		//$tree[] = &$items[$item['pid']];
		//}
	}
	return
}

// 查询
func (this *Type) Find(id int) (re Type, err error) {
	err = Db.First(&re, id).Error
	return
}

// status 设置
func (this *Type) SetStatus(id, status int) (code int, msg string) {
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
func (this *Type) Save(data Type) (code int, msg string) {
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
func (this *Type) Add(data Type) (code int, msg string) {
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
func (this *Type) AjaxDel(id int) (code int, msg string) {
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
func (this *Type) AjaxDelAll(ids string) (code int, msg string) {
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