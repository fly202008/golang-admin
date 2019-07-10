{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="/admin/book/index"><i class="layui-icon layui-icon-list"></i>列表</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon layui-icon-refresh"></i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding: 10px;">
    <legend><b>{{.t.Title}}</b></legend>
    <form class="layui-form changePwd" name="mainform" id="mainform" action="" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">栏目</label>
            <div class="layui-input-block">
                <select name="typeid" lay-verify="required">
                    <option value="">==请选择==</option>
                    {{range $k,$v := .typeData}}
                    <option value="{{$v.Id}}">{{$v.Name}}</option>
                    {{end}}
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">书籍名</label>
            <div class="layui-input-block">
                <input type="text" name="name" value="" placeholder="请输入书籍名" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">采集网址</label>
            <div class="layui-input-block">
                <select name="url" lay-verify="required">
                    <option value="https://sou.xanbhx.com/search?siteid=qula&q=">笔趣阁搜索  |——  https://sou.xanbhx.com/search?siteid=qula&q=</option>
{{/*                    <option value="http://m.xbiquge.la/">新笔趣阁</option>*/}}
                 </select>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" href="javascript:;" onclick="submit()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</fieldset>

<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });
</script>
<script>
    function submit()
    {
        if($("[name='typeid']").val() == '') {
            layer.alert("请选择栏目名");
            return;
        }
        if($("[name='name']").val() == '') {
            layer.alert("请输入书籍名称");
            return;
        }
        ajaxAdd();
    }
</script>

{{template "admin/layout/footer.tpl" .}}