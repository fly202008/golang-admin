<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="application/xhtml+xml;charset=utf-8"/>
    <title>搜索小说</title>
    <meta name="keywords" content="{{.config.keywords}}" />
    <meta name="description" content="{{.config.description}}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <link rel="stylesheet" href="/static/index/css/searchwap.css"/>
</head>
<body>
<strong></strong>
<header class="channelHeader">
    <a class="iconback" href="javascript:history.go(-1);">
        <svg class="lnr lnr-chevron-left-circle">
            <use xlink:href="#lnr-chevron-left-circle"></use>
        </svg>
    </a>
    搜索小说
    <a class="iconhome" href="/">
        <svg class="lnr lnr-home">
            <use xlink:href="#lnr-home"></use>
        </svg>
    </a>
</header>
<form class="searchForm" action="" method="" data-target0="" data-target1="/search">
    <input type="search" name="q" class="searchForm_input searchForm_input2" placeholder="输入书名•作者"/>
    <input type="hidden" name="s" value="920895234054625192"/>
    <input type="hidden" name="t" value="m"/>
    <input type="hidden" name="siteid" value="qula"/>

    <span class="serach_span">
         <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use xlink:href="#lnr-magnifier"></use></svg></span>
         <span class="s_submitbtn">搜索</span>
    </span>

    <div class="searchTarge">
        <p class="TargeTitle">
            <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use
                            xlink:href="#lnr-magnifier"></use></svg></span>
            <span class="TargeCurrent" data-id="1">站内</span>
            <span class="s_chevrondown"><svg class="lnr lnr-chevron-down"><use
                            xlink:href="#lnr-chevron-down"></use></svg></span>
        </p>
        <ul class="TargeList" class="active">
            <li data-id="1">站内</li>
            <li data-id="0">百度</li>
        </ul>
    </div>
</form>
<div class="recommend mybook">
    {{range $k,$v := .data}}
    <div class="hot_sale">
        <span class="num num2"> {{$v.SearchId}}</span>
        <a href="/book?bookid={{$v.BookId}}">
            <p class="title">{{$v.Name}}</p>
            <p class="author">{{$v.Author}}</p>
            <p class="author">{{$v.Status}}</p>
        </a>
    </div>
    {{end}}
    <div class="hot_sale hot_saleEm">
        <span class="num num2"> 22</span>
        <a href="https://m.qu.la/book/93858/">
            <p class="title">
                人间天                </p>
            <p class="author">
                玄幻奇幻 | 作者：南风秦                </p>
            <p class="author">
                连载 | 更新：第五十二章:返祖                </p>
        </a>
    </div>


    <p class="page">
        <a href="?siteid=qula&t=m&q=天&page=1">
            [上页]
        </a>
        <input type="text" class="page_txt" value="2/88"
               size="5" name="txtPage" id="txtPage"/>
        <a id="nextPage"
           href="?siteid=qula&t=m&q=天&page=3">
            [下页]
        </a>
    </p>
</div>

<form class="searchForm" action="" method="" data-target0="" data-target1="/search">
    <input type="search" name="q" class="searchForm_input searchForm_input2" placeholder="输入书名•作者"/>
    <input type="hidden" name="s" value="920895234054625192"/>
    <input type="hidden" name="t" value="m"/>
    <input type="hidden" name="siteid" value="qula"/>

    <span class="serach_span">
         <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use xlink:href="#lnr-magnifier"></use></svg></span>
         <span class="s_submitbtn">搜索</span>
    </span>

    <div class="searchTarge">
        <p class="TargeTitle">
            <span class="s_magnifier"><svg class="lnr lnr-magnifier"><use
                            xlink:href="#lnr-magnifier"></use></svg></span>
            <span class="TargeCurrent" data-id="1">站内</span>
            <span class="s_chevrondown"><svg class="lnr lnr-chevron-down"><use
                            xlink:href="#lnr-chevron-down"></use></svg></span>
        </p>
        <ul class="TargeList" class="active">
            <li data-id="1">站内</li>
            <li data-id="0">百度</li>
        </ul>
    </div>
</form>

<footer>
    <a href="#top">
        <svg class="lnr lnr-arrow-up-circle">
            <use xlink:href="#lnr-arrow-up-circle"></use>
        </svg>
    </a>
    <p class="version channel">
        <a href="https://m.qu.la/">首页</a>
    </p>
</footer>

<script type="text/javascript" src="/static/index/scripts/zepto.min.js"></script>
<script type="text/javascript" src="/static/index/scripts/searchwap.js"></script>
</body>
</html>

