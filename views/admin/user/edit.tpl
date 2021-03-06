{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="/admin/user/index"><i class="layui-icon layui-icon-list"></i>列表</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon layui-icon-refresh"></i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding: 10px;">
    <legend><b>{{.t.Title}}</b></legend>
    <form class="layui-form changePwd" name="mainform" id="mainform" action="" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" value="{{.data.Username}}" disabled="disabled" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="text" name="Password" value="" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">状态{{.data.Status}}</label>
            <div class="layui-input-block">
                <input type="radio" name="Status" value="2" title="冻结" {{if eq 2 .data.Status}}checked{{end}}>
                <input type="radio" name="Status" value="1" title="正常" {{if eq 1 .data.Status}}checked{{end}}>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <input type="hidden" name="Id" value="{{.data.Id}}">
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
        ajaxEdit();
    }
</script>

{{template "admin/layout/footer.tpl" .}}