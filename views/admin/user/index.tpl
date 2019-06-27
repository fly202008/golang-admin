{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="javascript:;" onclick="add()"><i class="layui-icon">&#xe654;</i>添加</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon">&#xe669;</i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding-right: 5px;">
    <legend><b>{{.t.Title}}</b></legend>
    <div class="layui-field-box layui-form">
        <form action="" id="searchForm" method="get">
            <div class="layui-form-item">
                <label class="layui-form-label">搜索：</label>
                <div class="layui-inline">
                    <input type="text" name="username" value="{{.where.Username}}" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline" style="width: 150px;">
                    <select name="status" id="status">
                        <option value="">=状态=</option>
                        <option value="1" {{if eq .where.Status 1}}selected{{end}}>正常</option>
                        <option value="2" {{if eq .where.Status 2}}selected{{end}}>冻结</option>
                    </select>
                </div>
                <div class="layui-inline" style="width:100px;">
                    <input type="text" name="time1" placeholder="开始时间" onclick="WdatePicker()" value="{{.where.Time1}}" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline" style="width:100px;">
                    <input type="text" name="time2" placeholder="结束时间" onclick="WdatePicker()" value="{{.where.Time2}}" autocomplete="off" class="layui-input">
                </div>
                <button class="layui-btn"><i class="layui-icon">&#xe615;</i> </button>
                <a href="/{{.Request.Module}}/{{.Request.Controller}}/{{.Request.Action}}" class="layui-btn layui-btn-primary">重置</a>
            </div>
        </form>
    </div>
    <div style="margin: 0 10px;">
        <table class="layui-table" id="jsonTable" lay-filter="jsonTable"></table>
    </div>

</fieldset>
<!--左上角操作-->
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete">批量删除</button>
    </div>
</script>
<!--操作-->
<script type="text/html" id="toolBar">
    <div class="layui-btn-group">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" lay-event="update">
            <i class="layui-icon layui-icon-edit"></i>
        </button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-xs" lay-event="delete">
            <i class="layui-icon layui-icon-delete"></i>
        </button>
    </div>
</script>
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
            ,toolbar: '#toolbarDemo' // 工具条、打印、导出、筛选列
            ,url: '/admin/user/index' //数据接口
            ,method: 'get'
            ,page: true //开启分页
            ,limit: 10
            ,where:{status:$("[name='status']").val(),username:$("[name='username']").val(),time1:$("[name='time1']").val(),time2:$("[name='time2']").val()}
            ,limits : [10,20,50,100,1000]
            ,cols: [[ //表头
                {type: "checkbox", fixed: "left", width: 50}
                ,{field: 'Id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'Username', title: '用户名', width:80}
                ,{field: 'Password', title: '密码',  sort: true}
                ,{
                    field: 'Status', title: '状态', align: 'center', minWidth: 80,  sort: true, templet: function (data) {
                        var setStatus = data.Status == 1 ? 2 : 1;
                        return data.Status == 1 ? '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', ' + setStatus + ')">正常</span>' : '<span class="layui-badge layui-bg-orange status_pointer" onclick="setStatus(' + data.Id + ', ' + setStatus + ')">冻结</span>';
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
                ,{title: '操作', width: 170, templet: '#toolBar', fixed: "right", align: "center"}
            ]]
        });

        //监听事件
        table.on('toolbar(jsonTable)', function(obj){
            var layEvent = obj.event;
            console.log("layEvent = "+layEvent);
            var checkStatus = table.checkStatus(obj.config.id);
            console.log(checkStatus)
            switch(obj.event){
                case 'add':
                    add();
                    break;
                case 'delete':
                    layer.msg('删除');
                    break;
                case 'update':
                    layer.msg('编辑');
                    break;
            };
        });

        //监听事件
        table.on('tool(jsonTable)', function(obj){
            var layEvent = obj.event;

            console.log(obj)
            switch(layEvent){
                case 'delete':
                    del(obj.data.Id)
                    break;
                case 'update':
                    edit(obj.data.Id)
                    break;
            };
        });

    });
</script>

{{template "admin/layout/footer.tpl" .}}