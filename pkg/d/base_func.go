package d

import (
	"fmt"
	"time"
)

/**
 *	str 转化为时间戳的字符串 注意 这里的小时和分钟还要秒必须写 因为是跟着模板走的 修改模板的话也可以不写
 */
func Strtotiom(str string) (timestamp int64) {
	if len(str) < 11 {
		str = str + " 00:00:00"
	}
	timeLayout := "2006-01-02 15:04:05"                             //转化所需模板
	loc, _ := time.LoadLocation("Local")                            //重要：获取时区
	theTime, _ := time.ParseInLocation(timeLayout, str, loc) //使用模板在对应时区转化为time.time类型
	timestamp = theTime.Unix()                                            //转化为时间戳 类型是int64
	fmt.Println(theTime)                                            //打印输出theTime 2015-01-01 15:15:00 +0800 CST
	fmt.Println(timestamp)                                                 //打印输出时间戳 1420041600
	return
}