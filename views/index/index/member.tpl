<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>我的书架--【{{.config.title}}】</title>
    <meta name="keywords" content="{{.config.keywords}}" />
    <meta name="description" content="{{.config.description}}" />
    <meta name="MobileOptimized" content="240"/>
    <meta name="applicable-device" content="mobile"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta http-equiv="Cache-Control" content="max-age=300" />
    <meta http-equiv="Cache-Control" content="no-transform " />
    <link rel="stylesheet" type="text/css" href="/static/index/css/style.css" />
    <script type="text/javascript" src="/static/index/scripts/jquery.min.js"></script>
    <script src="/static/index/scripts/wap.js"></script>
    <script src="/static/index/scripts/comm.js"></script>
</head>
<body>
<div id="app">
    {{template "index/index/header.tpl" .}}

    <div class="toptab"><span class="active">我的书架 - 会员中心</span></div>
    <div class="read_book">
        <div class="bookbox">
            <div class="bookimg">
                <a href="/wapbook/36060.html">
                    <img src="http://www.xbiquge.la/files/article/image/36/36060/36060s.jpg" onerror="this.src='http://www.xbiquge.la/modules/article/images/nocover.jpg'"></a>
            </div><div class="bookinfo">
                <h4 class="bookname"><i class="iTit"><a href="/wapbook/36060.html"></a></i></h4>
                <div class="cl0"></div><div class="author">作者：绝人</div><div class="cl0"></div>
                <div class="updatelast"><span>更新到：</span><a href="/wapbook/36060_18611395.html">第三百七十二章  老韩会来救我们吗？</a></div>
                <div class="update"><span>已读到：</span><a href="/wapbook/36060_18588781.html">第三百六十六章  胆小的窝囊废？</a></div></div>
            <div class="delbutton"><a class="del_but" href="javascript:if(confirm('确实要将本书移出书架么？')) document.location='/delbookcase/36060.php';">删除</a></div>
        </div>
    </div>

    {{template "index/index/footer.tpl" .}}
</div>
</body>
</html>
<script>
    data = {{.json}}

    for (i=0;i<data.length;i++){
        $.ajax({
            url:"http://127.0.0.1:8080/api/book/show?bookid=10489",
            type:"get",
            dataType:"json",
            success:function (re) {
                var html = "<div class='bookbox'>\n" +
                    "            <div class='bookimg'>\n" +
                    "                <a href='/wapbook/36060.html'>\n" +
                    "                    <img src='http://www.xbiquge.la/files/article/image/36/36060/36060s.jpg' onerror='this.src='http://www.xbiquge.la/modules/article/images/nocover.jpg''></a>\n" +
                    "            </div><div class='bookinfo'>\n" +
                    "                <h4 class='bookname'><i class='iTit'><a href='/wapbook/36060.html'>" + re.Name + "</a></i></h4>\n" +
                    "                <div class='cl0'></div><div class='author'>作者：" + re.Author + "</div><div class='cl0'></div>\n" +
                    "                <div class='updatelast'><span>更新到：</span><a href='/article?bookid=" + re.Id + "&articleid=" + re.EndcaseId + "'>" + re.Endcase + "</a></div>\n" +
                    "                <div class='update'><span>已读到：</span><a href='/article?bookid=" + data[i]['ArticleId'] + "&articleid=" + re.EndcaseId + "'>" + re.EndArticleName + "</a></div></div>\n" +
                    "            <div class='delbutton'><a class='del_but' href='javascript:;' onclick='delcase(" + data[i]['Id'] + ")'>删除</a></div>\n" +
                    "        </div>";
            }
        })
    }

    // 删除书签
    function delcase(id) {

    }
</script>