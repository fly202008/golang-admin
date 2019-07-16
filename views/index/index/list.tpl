<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="application/xhtml+xml;charset=utf-8" />
    <title>分类【{{.config.title}}】_{{.config.title}}小说网_{{.config.title}}小说阅读网_{{.config.title}}</title>
    <meta name="keywords" content="{{.config.keywords}}" />
    <meta name="description" content="{{.config.description}}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" type="text/css" href="/static/index/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/static/index/css/sort.css" />
</head>
<body>
<header class="channelHeader">
    <a href="javascript:history.go(-1);" class="iconback">
        <svg class="lnr lnr-chevron-left-circle"><use xlink:href="#lnr-chevron-left-circle"></use></svg>
    </a>
    分类
    <a href="/" class="iconhome">
        <svg class="lnr lnr-home"><use xlink:href="#lnr-home"></use></svg>
    </a>
</header>
<nav class="sortChannel_nav">
    {{range $k,$v := .typeData}}
    <a class="{{if eq $.id $v.Id}}on{{end}}" href="/list?id={{$v.Id}}">{{$v.Name}}</a>
    {{end}}
</nav>
<div class="recommend">
    <div id="main">
        {{range $k,$v := .list}}
        <div class="hot_sale">
            <a href="/book?bookid={{$v.BookId}}">
                <img class="lazy" src="{{$v.Image}}" onerror="this.src='/static/index/picture/nopic.gif'">
                <p class="title">{{$v.Name}}</p>
                <p class="author">作者：{{$v.Author}}</p>
            </a>
            <p class="review">
                <span class="longview"><svg class="lnr lnr-chevron-down-circle"><use xlink:href="#lnr-chevron-down-circle"></use></svg></span>
                简介：{{$v.Info}}
            </p>
        </div>
        {{end}}
    </div>
    <p class="page">
        {{if ne 0 .pre}}<a href="/list?typeid={{.id}}&page={{.pre}}">[上页]</a>{{end}}
        <input type="text" class="page_txt" value="{{.page}}/{{.total}}" size="5" name="txtPage" id="txtPage" />
        {{if ne 0 .next}}<a id="nextPage" href="/list?typeid={{.id}}&page={{.next}}">[下页]</a>{{end}}
    </p>
    <br />
</div>
<script type="text/javascript" src="/static/index/scripts/zepto.min.js"></script>
<script language="javascript" type="text/javascript" src="/static/index/scripts/common.js"></script>
<script language="javascript" type="text/javascript" src="/static/index/scripts/sort.js"></script>
<script language="javascript" type="text/javascript" src="/static/index/scripts/lazyload.js"></script>
<form class="searchForm" name="from1" autocomplete="off" action="/search" method="get">
    <input type="search" name="keyword" class="searchForm_input searchForm_input2" placeholder="输入书名•作者"/>

    <span class="serach_span">
         <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use xlink:href="#lnr-magnifier"></use></svg></span>
         <span class="s_submitbtn">搜索</span>
    </span>

    <div class="searchTarge">
        <p class="TargeTitle">
            <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use
                            xlink:href="#lnr-magnifier"></use></svg></span>
            <span class="TargeCurrent" data-id="1">站内</span>
        </p>
    </div>
</form>
<footer>
    <a href="#top"><svg class="lnr lnr-arrow-up-circle"><use xlink:href="#lnr-arrow-up-circle"></use></svg></a>
    <p class="version channel">
        <a href="/">首页</a>
        <a href="/" onclick="beforeBookCase(this)">我的书架</a>
    </p>
</footer>


</body>
</html>
