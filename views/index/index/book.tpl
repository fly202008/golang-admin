<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>{{.data.Name}}小说_{{.data.Author}}_{{.data.Name}}最新章节_{{.data.Name}}无弹窗_新笔趣阁</title>
    <meta name="keywords" content="{{.data.Name}},{{.data.Name}}最新章节" />
    <meta name="description" content="如果您喜欢小说{{.data.Name}}，请将{{.data.Name}}最新章节目录加入收藏方便您下次阅读,新笔趣阁将在第一时间更新小说{{.data.Name}}，发现没及时更新，请告知我们,谢谢!" />
    <meta name="MobileOptimized" content="240"/>
    <meta name="applicable-device" content="mobile"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta http-equiv="Cache-Control" content="max-age=0" />
    <meta http-equiv="Cache-Control" content="no-transform " />
    <meta property="og:type" content="novel"/>
    <meta property="og:title" content="{{.data.Name}}"/>
    <meta property="og:description" content="{{.data.Info}}"/>
    <meta property="og:image" content="{{.data.Image}}"/>
    <meta property="og:novel:category" content="{{.data.Endcase}}"/>
    <meta property="og:novel:author" content="{{.data.Author}}"/>
    <meta property="og:novel:book_name" content="{{.data.Name}}"/>
    <meta property="og:novel:status" content="{{if eq 1 .data.Status}}完结{{else if eq 2 .data.Status}}连载{{else}}未知{{end}}"/>
    <meta property="og:novel:update_time" content="{{.data.Updatatime}}"/>
    <meta property="og:novel:latest_chapter_name" content="{{.data.Endcase}}"/>
    <link rel="stylesheet" type="text/css" href="/static/index/plus/nicepage/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="/static/index/css/style.css" />
    <script type="text/javascript" src="/static/index/scripts/jquery.min.js"></script>
    <script src="/static/index/scripts/wap.js"></script>
    <script src="/static/index/scripts/comm.js"></script>
    <script language="Javascript" src="static/index/plus/nicepage/js/layui.js"></script>
    <script language="Javascript" src="static/index/plus/nicepage/js/nicePage.js"></script>
    <style type="text/css">
        #notice {max-width: 320px;background: #ECF0F0;height: 100px;margin: auto;border: 1px #65bbec solid;padding: 1px 20px;}
        #notice .btn{margin:5px 3px; padding:5px 18px 5px 18px; background-size:20px; background:#65bbec; color:#fff; text-align:center; font-size:16px; border-radius:5px; box-shadow: 0 2px 1px #65bbec inset;}
    </style>
</head>
<body>
<div class="header" id="bqgmb_head">
    <div class="back"><a href="javascript:history.go(-1);">返回</a></div>
    <h1 id="bqgmb_h1">{{.data.Name}} 目录共{{.total}}章</h1>
    <div class="back_r"><a href="/">首页</a></div>
</div>
<div class="cover">
    <div class="block">
        <div class="block_img2"><img src="{{.data.Image}}" border="0" width='92' height='116' onerror="this.src='/static/index/picture/nopic.gif'"/></div>
        <div class="block_txt2">
            <p><a href="/article?bookid={{.data.Id}}&articleid={{.startUrl}}"><h2>{{.data.Name}}</h2></a></P>
            <p>作者：{{.data.Author}}</p>
            <p>分类：<a href="/list?typeid={{.data.Typeid}}">{{.data.Typename}}</a></p>
            <p>状态：{{if eq 1 .data.Status}}完结{{else if eq 2 .data.Status}}连载{{else}}未知{{end}}</p>
            <p>更新：{{.data.Updatatime}}</p>
            <p>最新：<a href="/article?bookid={{.data.Id}}&articleid={{.data.EndcaseId}}">{{.data.Endcase}}</a></p>
        </div>
    </div>
    <div style="clear:both"></div>
    <div class="ablum_read" id="btnlist">
        <span class="margin_right"><a href="/article?bookid={{.data.Id}}&articleid={{.startUrl}}">开始阅读</a></span>
        <span><a href="Javascript:void(0);" onclick="javascript:putbookcase(10489);">加入书架</a></span>
    </div>
    <div class="intro">{{.data.Name}}小说简介</div>
    <div class="intro_info">{{.data.Info}}<br/>最新章节推荐地址：<a href="/article?bookid={{.data.Id}}&articleid={{.data.EndcaseId}}">{{.data.Endcase}}</a>
    </div>
    <div class="intro str-over-dot">{{.data.Name}}最新章节 更新时间：{{.data.Updatatime}}</div>
    <ul class="chapter">
        {{range $k,$v := .newlist}}
        <li>{{str2html $v.Name}}</li>
        {{end}}
    </ul>
    <div class="intro">正文</div>
    <div>
        <!--以下为两个必须div元素-->
        <div id="table"></div>
        <div id="pageBar"></div>
    </div>
    <div class="listpage">
        <script>
            //标准json格式 目前只支持[{a:b,c:d},{a:b,c:d}]此种格式
            //
            json = {{.json}};
            //nameList与widthList的数组长度要一致
            var nameList = ['序号', '书籍ID', '章节'] //table的列名
            var widthList = ['0%', '0%', '100%'] //table每列的宽度

            /**
             * 初始化设置nicepage组件    v1.0
             *-------------------------------------------------------------
             * 进行数据组装,与layui交互进行元素渲染
             *-------------------------------------------------------------
             * @param    {string}  table     table的div id
             * @param    {string}  bar     底部分页的div id
             * @param    {int}  limit     每页默认行数
             * @param    {string}  color     底部分页的颜色
             * @param    {array}  layout     底部分页的布局,具体可参考layui api
             *
             * @date     2018-10-19
             * @author   duzhen wechat：wenxuejn
             */
            $(function () {
                nicePage.setCfg({
                    table: 'table',
                    bar: 'pageBar',
                    limit: 20,
                    color: '#1E9FFF',
                    layout: ['count', 'prev', 'page', 'next', 'limit', 'skip']
                });
            }); //初始化完成
        </script>
    </div>
</div>
{{template "index/index/footer.tpl" .}}
</body>
</html>