<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>{{.webname}}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="/favicon.ico">
    <link rel="stylesheet" href="/static/admin/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/static/admin/css/index.css" media="all" />
    <script src="/static/plus/jquery-v1.7.2.js"></script>
</head>
<body class="main_body">
<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header header">
        <div class="layui-main mag0">
            <a href="#" class="logo">{{.webname}}</a>
            <!-- 显示/隐藏菜单 -->
            <a href="javascript:;" class="seraph hideMenu"><i class="layui-icon layui-icon-align-left"></i> </a>
            <!-- 顶级菜单 -->
            <ul class="layui-nav mobileTopLevelMenus" mobile>
                <li class="layui-nav-item" data-menu="contentManagement">
                    <a href="javascript:;"><i class="seraph icon-caidan"></i><cite>layuiCMS</cite></a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this" data-menu="contentManagement"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>内容管理</cite></a></dd>
                        <dd data-menu="memberCenter"><a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>用户中心</cite></a></dd>
                        <dd data-menu="systemeSttings"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe620;">&#xe620;</i><cite>系统设置</cite></a></dd>
                    </dl>
                </li>
            </ul>
            <ul class="layui-nav topLevelMenus" pc>
                <!--<li class="layui-nav-item layui-this" data-menu="contentManagement">-->
                <!--<a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>内容管理</cite></a>-->
                <!--</li>-->
                <!--<li class="layui-nav-item" data-menu="memberCenter" pc>-->
                <!--<a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>用户中心</cite></a>-->
                <!--</li>-->
                <!--<li class="layui-nav-item" data-menu="systemeSttings" pc>-->
                <!--<a href="javascript:;"><i class="layui-icon" data-icon="&#xe620;">&#xe620;</i><cite>系统设置</cite></a>-->
                <!--</li>-->
            </ul>
            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item" pc>
                    <a href="javascript:;" class="clearCache"><i class="layui-icon" data-icon="&#xe640;">&#xe640;</i><cite>清除缓存</cite><span class="layui-badge-dot"></span></a>
                    <!--<a href="{:url('index/clearCache')}" class="clearCache"><i class="layui-icon" data-icon="&#xe640;">&#xe640;</i><cite>清除缓存</cite><span class="layui-badge-dot"></span></a>-->
                </li>
                <!--<li class="layui-nav-item lockcms" pc>-->
                <!--<a href="javascript:;"><i class="seraph icon-lock"></i><cite>锁屏</cite></a>-->
                <!--</li>-->
                <li class="layui-nav-item" id="userInfo">
                    <a href="javascript:;"><img src="/static/admin/images/userface4.jpg" class="layui-nav-img userAvatar" width="35" height="35"><cite class="adminName">{{.info.Username}}</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-url="{:url('user/editme')}"><i class="layui-icon layui-icon-edit"></i><cite>修改密码</cite></a></dd>
                        <dd pc><a href="javascript:;" class="changeSkin"><i class="layui-icon">&#xe61b;</i><cite>更换皮肤</cite></a></dd>
                        <dd><a href="/admin/loginout" class="signOut"><i class="layui-icon layui-icon-release"></i><cite>退出</cite></a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="user-photo">
            <a class="img" title="我的头像" ><img src="/static/admin/images/userface4.jpg" class="userAvatar"></a>
            <p>你好！<span class="userName">{{.info.Username}}</span>, 欢迎登录</p>
        </div>
        <!-- 搜索 -->
        <!--<div class="layui-form component">-->
        <!--<select name="search" id="search" lay-search lay-filter="searchPage">-->
        <!--<option value="">搜索页面或功能</option>-->
        <!--<option value="1">layer</option>-->
        <!--<option value="2">form</option>-->
        <!--</select>-->
        <!--<i class="layui-icon">&#xe615;</i>-->
        <!--</div>-->
        <div class="navBar layui-side-scroll" id="navBar">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-this">
                    <a href="javascript:;" data-url="{:url('main')}"><i class="layui-icon" data-icon=""></i><cite>后台首页</cite></a>
                </li>

                <li class="layui-nav-item">
                    <a>
                        <i class="layui-icon" data-icon=""></i>
                        <cite>用户管理</cite>
                        <span class="layui-nav-more"></span>
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a data-url="/admin/user/index">
                                <i class="layui-icon" data-icon=""></i>
                                <cite>用户列表</cite></a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>
                        <i class="layui-icon" data-icon=""></i>
                        <cite>内容管理</cite>
                        <span class="layui-nav-more"></span>
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a data-url="/admin/type/index">
                                <i class="layui-icon" data-icon=""></i>
                                <cite>栏目列表</cite></a>
                        </dd>
                    </dl>
                    <dl class="layui-nav-child">
                        <dd>
                            <a data-url="/admin/book/index">
                                <i class="layui-icon" data-icon=""></i>
                                <cite>书籍列表</cite></a>
                        </dd>
                    </dl>
                </li>
                <!--<li class="layui-nav-item">-->
                <!--<a>-->
                <!--<i class="layui-icon" data-icon=""></i>-->
                <!--<cite>权限管理</cite>-->
                <!--<span class="layui-nav-more"></span>-->
                <!--</a>-->
                <!--<dl class="layui-nav-child">-->
                <!--<dd>-->
                <!--<a data-url="{:url('privilege/lst')}">-->
                <!--<i class="layui-icon" data-icon=""></i>-->
                <!--<cite>权限列表</cite></a>-->
                <!--</dd>-->
                <!--</dl>-->
                <!--</li>-->
                <!--<li class="layui-nav-item">-->
                <!--<a href="javascript:;" data-url="{:url('gii/index/index')}"><i class="layui-icon">&#xe640;</i><cite>生成工具</cite></a>-->
                <!--</li>-->
                <!--<li class="layui-nav-item">-->
                <!--<a><i class="layui-icon" data-icon=""></i><cite>系统配置</cite><span class="layui-nav-more"></span></a>-->
                <!--<dl class="layui-nav-child">-->
                <!--<dd class="">-->
                <!--<a data-url="{:url('config/lst')}"><i class="layui-icon" data-icon=""></i><cite>参数设置</cite></a>-->
                <!--</dd>-->
                <!--<dd class="layui-this"><a data-url="{:url('config_group/lst')}"><i class="layui-icon" data-icon=""></i><cite>参数分组</cite></a></dd>-->
                <!--</dl>-->
                <!--</li>-->
                <!--<li class="layui-nav-item">-->
                <!--<a>-->
                <!--<i class="layui-icon">&#xe60a;</i>-->
                <!--<cite>日志记录</cite>-->
                <!--<span class="layui-nav-more"></span>-->
                <!--</a>-->
                <!--<dl class="layui-nav-child">-->
                <!--<dd>-->
                <!--<a data-url="{:url('loginerror/lst')}">-->
                <!--<i class="layui-icon">&#xe60a;</i>-->
                <!--<cite>登录错误日志</cite></a>-->
                <!--</dd>-->
                <!--</dl>-->
                <!--</li>-->
                <span class="layui-nav-bar" style="height: 0px; top: 67.5px; opacity: 0;"></span>
            </ul>
        </div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab mag0" lay-filter="bodyTab" id="top_tabs_box" style="z-index: 1000;">
            <ul class="layui-tab-title top_tab" id="top_tabs">
                <li class="layui-this" lay-id=""><i class="layui-icon">&#xe68e;</i> <cite>后台首页</cite></li>
            </ul>

            <ul class="layui_jump layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon caozuo">&#xe643;</i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon layui-icon-refresh"></i> 刷新当前</a></dd>
                        <dd><a href="javascript:;" class="closePageOther"><i class="seraph icon-prohibit"></i> 关闭其他</a></dd>
                        <dd><a href="javascript:;" class="closePageAll"><i class="seraph icon-guanbi"></i> 关闭全部</a></dd>
                    </dl>
                </li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon caozuo">&#xe643;</i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon layui-icon-refresh"></i> 刷新当前</a></dd>
                        <dd><a href="javascript:;" class="closePageOther"><i class="seraph icon-prohibit"></i> 关闭其他</a></dd>
                        <dd><a href="javascript:;" class="closePageAll"><i class="seraph icon-guanbi"></i> 关闭全部</a></dd>
                    </dl>
                </li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <iframe src="/admin/index/main"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <!--<div class="layui-footer footer">-->
    <!--<p><span>copyright @2018 驊驊龔頾</span>　　<a onclick="donation()" class="layui-btn layui-btn-danger layui-btn-sm">捐赠作者</a></p>-->
    <!--</div>-->
</div>

<!-- 移动导航 -->
<div class="site-tree-mobile"><i class="layui-icon">&#xe602;</i></div>
<div class="site-mobile-shade"></div>

<script type="text/javascript" src="/static/admin/layui/layui.js"></script>
<script type="text/javascript" src="/static/admin/js/index.js"></script>
<script type="text/javascript" src="/static/admin/js/cache.js"></script>
<script>
    //清除缓存
    $(".clearCache").click(function(){
        window.sessionStorage.clear();
        window.localStorage.clear();
        var index = layer.msg('清除缓存中，请稍候',{icon: 16,time:false,shade:0.8});
        $.ajax({
            url:"{:url('clearcache')}",
            type:"get",
            dataType:"json",
            data: $("#mainform").serialize(),
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    layer.close(index);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    })
</script>
</body>
</html>