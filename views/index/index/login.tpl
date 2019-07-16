<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>用户登录</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="MobileOptimized" content="240"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0,  minimum-scale=1.0, maximum-scale=1.0" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/static/index/css/style.css" />
    <script src="/static/index/scripts/wap.js"></script>
    <script src="/static/index/scripts/comm.js"></script>
    <script type="text/javascript" src="/static/index/scripts/jquery.min.js"></script>
    <style>
        .login{margin:0px 7px 10px 7px;}
        .login table{width:100%;}
        .login table .td1{width:50px;padding:20px 0px;}
        .login_name{border:1px solid #B7F3F9;height:25px;width:95%;border-radius:3px;}
        .login_btn{ display:block;margin:20px 10px 20px 10px; text-align:center;color:#fff; font-weight:bold;height:40px; line-height:40px;border-radius:2px}
        .login_tips{ display:block;margin:20px 10px 20px 10px;  text-align:center;color:red; font-weight:bold;height:40px; line-height:40px;border-radius:2px}
        .aclick_bat{background-color: #0080C0;color: white;font-weight: bold;font-size: 18px;width: 100%;height: 100%;height:40px;cursor:pointer;}
    </style>
</head>
<body>
<div class="header" id="_bqgmb_head">
    <div class="back"><a href="javascript:history.go(-1);">返回</a></div>
    <h1 id="_bqgmb_h1">用户登录</h1>
    <div class="back_r"><a href="/">首页</a></div>
</div>

<div>
    <form  method="post" action="/login" autocomplete="off">
        <div class="login">
            <table>
                <tr>
                    <td class="td1">帐号：</td><td><input id="username" autocomplete="off" type="text"  size="20" value="admin" maxlength="30" class="login_name" name="username"></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="td1">密码：</td><td><input id="userpass" size="20" maxlength="30" type="password" value="123456" class="login_name" name="password"></td>
                </tr>
            </table>
        </div>

        <a class='login_btn c_login_button'>
            <div class="aclick_bat" onclick="login()">登录</div>
        </a>
        <div><a class="login_btn c_login_button" href="/register">没有账号？点击注册</a></div>
    </form>
</div>

<script>
    function login()
    {
        var username = $("[name='username']").val();
        var password = $("[name='password']").val();
        if (username == "") {
            alert("请填用户名");
            return;
        }
        if (password == "") {
            alert("请填用密码");
            return;
        }
        $.ajax({
            url:"/login",
            type:"post",
            dataType:"json",
            data:{"username":username,"password":password},
            success:function(re)
            {
                if (re.code == 1) {
                    alert("登录成功!");
                    window.location.href = "/";
                } else {
                    alert(re.msg);
                }
            }
        })
    }
</script>
</body>
</html>