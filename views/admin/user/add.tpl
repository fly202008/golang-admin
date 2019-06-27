{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="{:url('lst')}"><i class="layui-icon layui-icon-list"></i>列表</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon layui-icon-refresh"></i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding: 10px;">
    <legend><b>{{.t.Title}}</b></legend>
    <form class="layui-form changePwd" name="mainform" id="mainform" action="{:url('add')}" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="Username" value="" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="text" name="Password" value="" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="Status" value="2" title="冻结">
                <input type="radio" name="Status" value="1" title="正常" checked>
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
        if($("[name='Username']").val() == '') {
            layer.alert("请输入用户名");
            return;
        }
        if($("[name='Password']").val() == '') {
            layer.alert("请输入密码");
            return;
        }
        ajaxAdd();
    }
</script>

{{template "admin/layout/footer.tpl" .}}