<div class="header">
    <div class="logo"><a href="/">{{.config.title}}</a></div>
    <div class="reg">
        <script>showlogin();</script>
    </div>
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