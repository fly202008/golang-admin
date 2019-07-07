{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="/admin/user/index"><i class="layui-icon layui-icon-list"></i>列表</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon layui-icon-refresh"></i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding: 10px;">
    <legend><b>{{.t.Title}}</b></legend>
    <form class="layui-form changePwd" name="mainform" id="mainform" action="{:url('add')}" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">栏目名</label>
            <div class="layui-input-block">
                <input type="text" name="Name" value="{{.data.Name}}" placeholder="请输入栏目名" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">导航显示</label>
            <div class="layui-input-block">
                <input type="checkbox" name="Is_navi" lay-skin="switch" checked value="{{.data.Is_navi}}" lay-filter="switchIs_navi" lay-text="显示|隐藏">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="text" name="Weight" value="{{.data.Weight}}" placeholder="越大越靠前" autocomplete="off" class="layui-input">
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
        //监听指定开关
        form.on('switch(switchIs_navi)', function(data){
            // this.checked ? 'true' : 'false'
            console.log(this.checked);
            var is_navi_info = this.checked ? '显示' : '隐藏';
            var is_navi = this.checked ? '1' : '2';
            $("[name='Is_navi']").val(is_navi);
            layer.tips(is_navi_info, data.othis)
        });
    });
</script>
<script>
    function submit()
    {
        ajaxEdit();
    }
</script>

{{template "admin/layout/footer.tpl" .}}