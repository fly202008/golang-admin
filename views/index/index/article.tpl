<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>正文卷 {{.data.Name}}_{{.config.title}}</title>
    <meta name="keywords" content="{{.book.Name}},{{.data.Name}}" />
    <meta name="description" content="{{.config.title}}提供了{{.book.Author}}创作的{{.book.Typename}}{{.book.Name}}干净清爽无错字的文字章节：正文卷 {{.data.Name}}。" />
    <meta name="MobileOptimized" content="240"/>
    <meta name="applicable-device" content="mobile"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta http-equiv="Cache-Control" content="max-age=0" />
    <meta http-equiv="Cache-Control" content="no-transform " />
    <link rel="stylesheet" type="text/css" href="/static/index/css/css.css" />
    <script type="text/javascript" src="/static/index/scripts/jquery.min.js"></script>
    <script src="/static/index/scripts/wap.js"></script>
    <script src="/static/index/scripts/comm.js"></script>
</head>
<body id="nr_body" class="nr_all c_nr">
<div class="header" id="_bqgmb_head">
    <div class="back"><a href="javascript:history.go(-1);">返回</a></div>
    <h1 id="_bqgmb_h1">{{.data.Name}}</h1>
    <div class="back_r"><a href="/">首页</a></div>
</div>
<div>
    <div class="nr_set">
        <div id="lightdiv" class="set1" onclick="nr_setbg('light')">关灯</div>
        <div id="huyandiv" class="set1" onclick="nr_setbg('huyan')">护眼</div>
        <div class="set2"><div>字:</div><div id="fontbig" onclick="nr_setbg('big')">大</div> <div id="fontmiddle" onclick="nr_setbg('middle')" >中</div> <div id="fontsmall" onclick="nr_setbg('small')">小</div></div>
        <div class="cc"></div>
    </div>
    <script>content1();</script>
    <div class="nr_page">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td class="prev">
                    {{if eq 0 .data.PreId}}
                        <a id="pt_prev" href="/book?bookid={{.data.BookId}}">无章节</a>
                    {{else}}
                        <a id="pt_prev" href="/article?bookid={{.data.BookId}}&articleid={{.data.PreId}}">上一章</a>
                    {{end}}
                </td>
                <td class="mulu"><a id="pt_mulu" href="/book?bookid={{.data.BookId}}">回目录</a></td>
                <td class="next">
                    {{if eq 0 .data.NextId}}
                        <a id="pt_next" href="/book?bookid={{.data.BookId}}">无章节</a>
                    {{else}}
                        <a id="pt_next" href="/article?bookid={{.data.BookId}}&articleid={{.data.NextId}}">下一章</a>
                    {{end}}
                </td>
                <td class="mulu"><a id="pt_shouye" href="/member">进书架</a></td>
            </tr>
        </table>
    </div>
    <div id="nr" class="nr_nr">
        <div id="nr1">{{.data.Body | str2html}}</div>
    </div>
    <div class="nr_page">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td class="prev">
                    {{if eq 0 .data.PreId}}
                        <a id="pb_prev" href="/book?bookid={{.data.BookId}}">无章节</a>
                    {{else}}
                        <a id="pb_prev" href="/article?bookid={{.data.BookId}}&articleid={{.data.PreId}}">上一章</a>
                    {{end}}
                </td>
                <td class="mulu"><a id="pb_mulu" href="/book?bookid={{.data.BookId}}">回目录</a></td>
                <td class="next">
                    {{if eq 0 .data.NextId}}
                        <a id="pb_next" href="/book?bookid={{.data.BookId}}">无章节</a>
                    {{else}}
                        <a id="pb_next" href="/article?bookid={{.data.BookId}}&articleid={{.data.NextId}}">下一章</a>
                    {{end}}
                </td>
                <td class="mulu"><a id='pb_shouye' href="Javascript:void(0);" onclick="javascript:putbookmark({{.data.BookId}},{{.data.Id}},'{{.data.Name}}');"><font>存书签</font></a></td>
            </tr>
        </table>
    </div>
</div>
{{template "index/index/footer.tpl" .}}
</body>
</html>