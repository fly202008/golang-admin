{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="javascript:;" onclick="add()"><i class="layui-icon">&#xe654;</i>添加</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon">&#xe669;</i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding-right: 5px;">
    <legend><b>{{.t.Title}}</b></legend>
    <div class="layui-field-box layui-form">
        <form action="" method="get">
            <div class="layui-form-item">
                <label class="layui-form-label">搜索：</label>
                <div class="layui-inline" style="width: 150px;"><select name="uid" id="channel"><option value="">=请选择=</option></select></div><div class="layui-inline" style="width:100px;">
                    <input type="text" name="time1" placeholder="开始时间" onclick="WdatePicker()" value="{:input('time1')}" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline" style="width:100px;">
                    <input type="text" name="time2" placeholder="结束时间" onclick="WdatePicker()" value="{:input('time2')}" autocomplete="off" class="layui-input">
                </div>
                <button class="layui-btn"><i class="layui-icon">&#xe615;</i> </button>
                <a href="{:url('lst')}" class="layui-btn layui-btn-primary">重置</a>
            </div>
        </form>
    </div>
    <div style="margin: 0 10px;">
        <table class="layui-table" id="jsonTable" lay-filter="jsonTable"></table>
    </div>

</fieldset>

<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form', 'table'], function(){
        var layer = layui.layer
            ,form = layui.form;
        var table = layui.table;
        form.on('checkbox(allselector)', function(data){
            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
            child.each(function(index, item){
                item.checked = data.elem.checked;
            });
            form.render('checkbox');
        });

        // 表格数据
        table.render({
            elem: '#jsonTable'
            ,url: '/admin/user/index' //数据接口
            ,method: 'get'
            ,page: true //开启分页
            ,limit: 10
            ,limits : [10,20,50,100]
            ,cols: [[ //表头
                {field: 'Id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'Username', title: '用户名', width:80}
                ,{field: 'Password', title: '密码',  sort: true}
                ,{
                    field: 'Status', title: '状态', align: 'center', minWidth: 80, templet: function (data) {
                        return data.Status == 1 ? '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', ' + data.Status + ')">正常</span>' : '<span class="layui-badge layui-bg-orange status_pointer" onclick="setStatus(' + data.Id + ', ' + data.Status + ')">冻结</span>';
                    }
                }
                ,{
                    field: 'Addtime', title: '添加时间', align: 'center', minWidth: 110, templet: function (data) {
                        return _strtotime(data.Addtime);
                    }
                }
                ,{
                    field: 'Last_login_time', title: '最后登录时间', align: 'center', minWidth: 110, templet: function (data) {
                        return _strtotime(data.Last_login_time);
                    }
                }
            ]]
        });

    });
</script>

{{template "admin/layout/footer.tpl" .}}