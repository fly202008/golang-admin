{{template "admin/layout/header.tpl" .}}

<div class="sysNotice col" style="margin-top: 20px;">
    <blockquote class="layui-elem-quote title">系统基本参数</blockquote>
    <table class="layui-table">
        <colgroup>
            <col width="150">
            <col>
        </colgroup>
        <tbody>
        <tr>
            <td>开发作者</td>
            <td class="author">admin</td>
        </tr>
        <tr>
            <td>网站首页</td>
            <td class="homePage"><a href="/" target="_blank">网站首页</a></td>
        </tr>
        <tr>
            <td>服务器操作系统</td>
            <td class="server">{{.os}}</td>
        </tr>
        <tr>
            <td>golang版本</td>
            <td class="server">{{.goVersion}}</td>
        </tr>
        <tr>
            <td>geego版本</td>
            <td class="server">{{.beegoVersion}}</td>
        </tr>
        <tr>
            <td>后台layui版本</td>
            <td class="server">v2.4.5</td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });
</script>

{{template "admin/layout/footer.tpl" .}}