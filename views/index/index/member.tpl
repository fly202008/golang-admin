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

    <div id="list_info"></div>

    {{template "index/index/footer.tpl" .}}
</div>
</body>
</html>
<script>
    data = {{.json}};
    if (!data) {
        $("#list_info").html("空空如也");
    }

    for (i=0;i<data.length;i++){
        var key = i;
        $.ajax({
            url:"/api/book/show?bookid=" + data[key]["BookId"] + "&key=" + key,
            type:"get",
            async: false,// 设置成同步
            dataType:"json",
            success:function (re) {
                if (re.code == 1){
                    re = re.data;
                    var ydd = data[key]["ArticleId"] == "undefined" ? "" : "<a href='/article?bookid=" + data[key]['ArticleId'] + "&articleid=" + re.EndcaseId + "'>" + data[key].EndArticleName + "</a>";
                    var html = "<div class='bookbox' id='bookbox_"+data[key]['Id']+"'>\n" +
                        "            <div class='bookimg'>\n" +
                        "                <a href='/book?bookid=" + data[key]["bookId"] + "'>\n" +
                        "                    <img src='" + re.Image + "' onerror='this.src='/static/index/picture/nopic.gif'></a>\n" +
                        "            </div><div class='bookinfo'>\n" +
                        "                <h4 class='bookname'><i class='iTit'><a href='/book?bookid=" + data[key]["bookId"] + "'>" + re.Name + "</a></i></h4>\n" +
                        "                <div class='cl0'></div><div class='author'>作者：" + re.Author + "</div><div class='cl0'></div>\n" +
                        "                <div class='updatelast'><span>更新到：</span><a href='/article?bookid=" + re.Id + "&articleid=" + re.EndcaseId + "'>" + re.Endcase + "</a></div>\n" +
                        "                <div class='update'><span>已读到：</span>"+ydd+"</div></div>\n" +
                        "            <div class='delbutton'><a class='del_but' href='javascript:;' onclick='delcase(" + data[key]['Id'] + ")'>删除</a></div>\n" +
                        "        </div>";
                    $("#list_info").append(html);
                } else {
                    alert(re.msg)
                }
            }
        })
    }

    // 删除书签
    function delcase(id) {
        $.ajax({
            url:"/delbookcase",
            data:{bookId:id},
            dataType:"json",
            success:function (re) {
                if (re.code == 1){
                    $("#bookbox_"+id).remove();
                } else {
                    alert(re.msg)
                }
            }
        })
    }
</script>