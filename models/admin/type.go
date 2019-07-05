package admin

import (
	"github.com/astaxie/beego/validation"
)

type Type struct {
	Id 	int
	Name string 	`grom:"size(32)"`
	Is_navi 	int
}

// 如果你的 struct 实现了接口 validation.ValidFormer
// 当 StructTag 中的测试都成功时，将会执行 Valid 函数进行自定义验证
func (this Type) Valid(v *validation.Validation) {
	if this.Id == 0 && this.Name == "" {
		// 通过 SetError 设置 Name 的错误信息，HasErrors 将会返回 true
		v.SetError("用户名", "不能为空")
	}
}

func (this Type) FindAll(re User) {

}