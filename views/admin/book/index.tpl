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
                    <input type="text" name="name" value="{{.where.Name}}" placeholder="请输入书名" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-inline" style="width: 150px;">
                    <select name="status" id="status">
                        <option value="">=状态=</option>
                        <option value="1" {{if eq .where.Status 1}}selected{{end}}>完结</option>
                        <option value="2" {{if eq .where.Status 2}}selected{{end}}>连载</option>
                        <option value="3" {{if eq .where.Status 3}}selected{{end}}>未知</option>
                    </select>
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
            ,url: '/admin/book/index' //数据接口
            ,method: 'get'
            ,page: true //开启分页
            ,limit: 10
            ,where:{status:$("[name='status']").val(),username:$("[name='name']").val(),author:$("[name='author']").val()}
            ,limits : [10,20,50,100,1000]
            ,cols: [[ //表头
                {type: "checkbox", fixed: "left", width: 50}
                ,{field: 'Id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'Name', title: '书名', width:80}
                ,{field: 'Author', title: '作者',  sort: true}
                ,{field: 'Updatatime', title: '最后更新时间',  sort: true}
                ,{field: 'Endcase', title: '最后章节',  sort: true}
                ,{field: 'Info', title: '小说简介',  sort: true}
                ,{field: 'Image', title: '小说封面',  templet: function (data) {
                        return "<img src='"+data.Image+"' style='width: 180px;height: 240px;'>"
                    }
                }
                ,{
                    field: 'Status', title: '状态', align: 'center', minWidth: 80,  sort: true, templet: function (data) {
                        var setStatus = data.Status == 1 ? 2 : 1;
                        if(data.Status == 1) {
                            return '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', 2)">完结</span>';
                        } else if(data.Status == 2) {
                            return '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', 1)">连载</span>';
                        } else {
                            return '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', 2)">未知</span>';
                        }
                    }
                }
                ,{field: 'Click', title: '点击量',}
                ,{field: 'Collect', title: '收藏量',}
                ,{
                    field: 'Addtime', title: '添加时间', align: 'center', minWidth: 110, templet: function (data) {
                        return _strtotime(data.Addtime);
                    }
                }
                ,{title: '操作', width: 170, templet: '#toolBar', fixed: "right", align: "center"}
            ]]
        });

        //监听事件
        table.on('toolbar(jsonTable)', function(obj){
            var layEvent = obj.event;
            // console.log("layEvent = "+layEvent);
            var checkStatus = table.checkStatus(obj.config.id);
            // console.log(checkStatus)
            switch(obj.event){
                case 'add':
                    add();
                    break;
                case 'delete':
                    var ids = new Array();
                    $(checkStatus.data).each(function (k,v) {
                        if (v['Id'] == 1) {
                            return true
                        }
                        ids.push(v['Id'])
                    })
                    if($.inArray("1",ids) > 0) {
                        ids.splice($.inArray("1",ids), 1);
                    }
                    if (ids != []) {
                        ajaxDelAll_table(ids.join(","));
                    }
                    // console.log(ids);
                    break;
            };
        });

        //监听事件
        table.on('tool(jsonTable)', function(obj){
            var layEvent = obj.event;

            console.log(obj)
            switch(layEvent){
                case 'delete':
                    ajaxDel(obj.data.Id)
                    break;
                case 'update':
                    edit(obj.data.Id)
                    break;
            };
        });

    });
</script>

{{template "admin/layout/footer.tpl" .}}