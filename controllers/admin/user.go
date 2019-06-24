package admin

import (
	"fmt"
	"quickstart/models/admin"
)

type UserController struct {
	BaseContorller
}

func (this *UserController) Index() {
	this.Data["t"] = &TmpField{"用户列表", "", ""}
	var model = new(admin.User)
	data := model.FindAll()
	// 附加field说明
	//data := make([]map[string]interface{}, len(result))
	//for k, v := range result {
	//	row := make(map[string]interface{})
	//	row["id"] = v.Id
	//	row["username"] = v.Username
	//	row["password"] = v.Password
	//	row["status"] = v.Status
	//	row["addtime"] = v.Addtime
	//	row["last_log_time"] = beego.Date(time.Unix(v.Last_login_time, 0), "Y-m-d H:i:s")
	//	data[k] = row
	//}
	fmt.Println(data)
	for k,v := range data {
		fmt.Printf("k = %d,v = %v\r", k, v)
	}
	this.Data["data"] = data
	this.fetch()
}
