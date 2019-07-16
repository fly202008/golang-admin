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
    {{template "index/index/header.tpl" .}}

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