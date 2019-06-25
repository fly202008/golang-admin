package admin

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"net/url"
	"time"
)

// 基本模型的定义
type Model struct {
	Id        uint `gorm:"primary_key"`
	Addtime int64
	Edittime time.Time
	Deletedtime *time.Time
}

var (
	Db *gorm.DB
)

func Init() {
	hostname := beego.AppConfig.String("hostname")
	hostport := beego.AppConfig.String("hostport")
	dbUsername := beego.AppConfig.String("dbUsername")
	dbPassword := beego.AppConfig.String("dbPassword")
	dbName := beego.AppConfig.String("dbName")
	timezone := beego.AppConfig.String("timezone")
	dbCharset := beego.AppConfig.String("dbCharset")
	tablePrefix := beego.AppConfig.String("tablePrefix")

	if hostport == "" {
		hostport = "3306"
	}
	dsn := dbUsername + ":" + dbPassword + "@tcp(" + hostname + ":" + hostport + ")/" + dbName + "?charset=" + dbCharset
	fmt.Println("dsn = ", dsn)

	if timezone != "" {
		dsn = dsn + "&loc=" + url.QueryEscape(timezone)
	}

	// 链接数据库
	Db, _ = gorm.Open("mysql", dsn)

	// 全局禁用表名复数
	Db.SingularTable(true) // 如果设置为true,`User`的默认表名为`user`,使用`TableName`设置的表名不受影响

	// 您可以通过定义DefaultTableNameHandler对默认表名应用任何规则
	gorm.DefaultTableNameHandler = func (Db *gorm.DB, defaultTableName string) string  {
		return tablePrefix + defaultTableName;
	}

	//defer Db.Close()
}

