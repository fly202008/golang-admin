<!DOCTYPE html>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>登录--layui后台管理模板 2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/static/plus/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/public.css" />
    <script type="text/javascript" src="/static/plus/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/static/plus/layui/layui.js"></script>
    <script type="text/javascript" src="/static/js/login.js"></script>
</head>
<body class="loginBody">
<form class="layui-form" name="mainform" method="post">
    <div class="login_face"><img src="/static/images/face.jpg" class="userAvatar"></div>
    <div class="layui-form-item input-item">
        <label for="userName">用户名</label>
        <input type="text" name="username" value="admin" placeholder="请输入用户名" autocomplete="off" id="userName" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input name="password" type="password" value="123456" placeholder="请输入密码" autocomplete="off" id="password" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item" id="imgCode">
        <label for="code">验证码</label>
        <input type="text" name="captcha" placeholder="请输入验证码" autocomplete="off" id="code" class="layui-input">
        <img src="{{.Vcode}}" id="captchaImg" style="height: 36px;float: left;cursor: pointer;" onclick="getCaptcha()">
        <input type="hidden" name="capid" value="">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:50px;left:0px;">记住我</label>
        <div class="layui-input-block" style="margin-left: 70px;">
            <select name="remember" lay-verify="required">
                <option value="">不用</option>
                <option value="3">三天</option>
                <option value="7">七天</option>
                <option value="15">十五天</option>
            </select>
        </div>
    </div>
    <!-- <div class="beg-pull-left beg-login-remember">
        <label>记住帐号？</label>
        <input type="checkbox" name="rememberMe" value="true" lay-skin="switch" checked title="记住帐号">
    </div> -->
    <div class="layui-form-item" style="margin-top:20px;">
        <a href="javascript:;" onclick="fun1()" class="layui-btn layui-block">登录</a>
        <!--<div style="margin-top: 10px;">-->
            <!--<a href="{:url('register')}" class="layui-btn layui-btn-primary layui-block">注册</a>-->
        <!--</div>-->
    </div>
    <!-- <div class="layui-form-item layui-row">
        <a href="javascript:;" class="seraph icon-qq layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
        <a href="javascript:;" class="seraph icon-wechat layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
        <a href="javascript:;" class="seraph icon-sina layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>
    </div> -->
</form>
</body>
</html>
<script>
    // 验证码
    function getCaptcha() {
        $.ajax({
            url:"/common/tool/captcha",
            type:"get",
            dataType: "json",
            data:{"captchaType":"number"},
            success:function (re) {
                if (re.code == 1) {
                    $("#captchaImg").attr("src", re.data);
                    $("[name='capid']").val(re.capid);
                } else {
                    layer.alert(re.msg);
                }
            }
        })
    }
    getCaptcha();
    function fun1()
    {
        var f = document.mainform;
        if(f.username.value=='') {
            layer.msg("请输入用户名");
            return;
        }
        if(f.password.value=='') {
            layer.msg("请输入密码");
            return;
        }
        $.ajax({
            url:"/admin/login",
            type:"POST",
            dataType:"json",
            data: $("[name='mainform']").serialize(),
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("window.location.href = '/admin'", 1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                    setTimeout("window.location.reload()",1000);
                }
            }
        })
    }
</script>
