<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>【{{.config.title}}】_{{.config.title}}小说网_{{.config.title}}小说阅读网_{{.config.title}}</title>
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
    <div class="header">
        <div class="logo"><a href="/">{{.config.title}}</a></div>
        <div class="reg"></div>
    </div>
    <div class="nav">
        <ul>
            <li><a href="/list?id=0">分类</a></li>
            <li><a href="/list?id=1">玄幻</a></li>
            <li><a href="/list?id=2">武侠</a></li>
            <li><a href="/list?id=3">都市</a></li>
            <li><a href="/list?id=6">网游</a></li>
            <div class="cc"></div>
        </ul>
    </div>
    <div class="search">
        <form action="/search">
            <table cellpadding="0" cellspacing="0" style="width:100%;">
                <tbody>
                <tr>
                    <td style="background-color:#fff; border:1px solid #CCC;"><input id="s_key" name="keyword" type="text" class="key" value="输入书名后搜索，宁可少字不要错字" onfocus="this.value=''"></td>
                    <td style="width:35px; background-color:#0080C0; background-image:url('/static/index/picture/search.png'); background-repeat:no-repeat; background-position:center;cursor: pointer;"><input name="submit" type="submit" value="" class="go"></td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
{{/*    <div class="article">*/}}
{{/*        <h2 class="title"><span>封面推荐</span></h2>*/}}
{{/*        <div class="block">*/}}
{{/*            <div class="block_img"><a href="/wapbook/10489.html"><img height=100 width=80 src="/static/index/picture/10489s.jpg" onerror="this.src='http://www.xbiquge.la/modules/article/images/nocover.jpg'"/></a></div>*/}}
{{/*            <div class="block_txt">*/}}
{{/*                <p><a href="/wapbook/10489.html"><h2>三寸人间</h2></a></p>*/}}
{{/*                <p>作者：耳根</p>*/}}
{{/*                <p><a href="/wapbook/10489.html">举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。</a></p>*/}}
{{/*            </div>*/}}
{{/*            <div style="clear:both"></div>*/}}
{{/*        </div>*/}}
{{/*    </div>*/}}
    <div id="list_info"></div>

    {{template "index/index/footer.tpl" .}}
</div>
<script>
    var type = {{.json}}
    for(i=0;i<=7;i++) {
        if(i == 0){
            getList(i,"推荐");
        }else {
            getList(i,type[i]["Name"]);
        }
    }
    function getList(id,name)
    {
        $.ajax({
            url:"http://127.0.0.1:8080/api/book/list?typeid="+id+"&page=1",
            type:"get",
            dataType:"json",
            success:function (re) {
                if (re.code == 1){
                    var html = "";
                    $(re.data).each(function (k,v) {
                        if (k == 0){
                            html += "<div class=\"article\">\n" +
                                "        <h2 class=\"title\"><span><a href='/list?typeid=" + id + "'>"+name+"</a></span><a href='/list?typeid=" + id + "'>更多...</a></h2>\n" +
                                "        <div class=\"block\">\n" +
                                "            <div class=\"block_img\"><a href='/book?bookid=" + v.BookId + "'><img height=100 width=80 src='" + v.Image + "' onerror='" + v.Image + "'/></a></div>\n" +
                                "            <div class=\"block_txt\">\n" +
                                "                <p><a href='/book?bookid=" + v.BookId + "'><h2>" + v.Name + "</h2></a></p>\n" +
                                "                <p>作者：" + v.Author + "</p>\n" +
                                "                <p><a href='/book?bookid=" + v.BookId + "'>" + v.Info + "</a></p>\n" +
                                "            </div>\n" +
                                "            <div style=\"clear:both\"></div>\n" +
                                "            <ul>\n";
                        }else {
                            html += "<li><a href='/book?bookid=" + v.BookId + "' class=\"blue\">" + v.Name + "</a>/" + v.Author + "</li>\n";
                        }

                    })
                    html +="</ul></div></div>";
                    var oldhtml = $("#list_info").html()
                    html = oldhtml + html
                    $("#list_info").html(html)
                }
            }
        })
    }
</script>
</body>
</html>