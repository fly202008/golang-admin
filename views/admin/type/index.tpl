{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="javascript:;" onclick="add()"><i class="layui-icon">&#xe654;</i>添加</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon">&#xe669;</i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding-right: 5px;">
    <legend><b>{{.t.Title}}</b></legend>
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
<div id="test1"></div>

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
    layui.use(['layer', 'form', 'table', 'tree'], function(){
        var layer = layui.layer
            ,form = layui.form;
        var table = layui.table;
        var tree = layui.tree;
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
            ,url: '/{{.Request.Module}}/{{.Request.Controller}}/index' //数据接口
            ,method: 'get'
            ,page: false //开启分页
            ,cols: [[ //表头
                {type: "checkbox", fixed: "left", width: 50}
                ,{field: 'Id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'Name', title: '栏目', width:180}
                ,{
                    field: 'Is_navi', title: '显隐', align: 'center', minWidth: 40,  sort: true, templet: function (data) {
                        var setStatus = data.Is_navi == 1 ? 2 : 1;
                        return data.Is_navi == 1 ? '<span class="layui-badge layui-bg-green status_pointer" onclick="setStatus(' + data.Id + ', ' + setStatus + ')">显示</span>' : '<span class="layui-badge layui-bg-orange status_pointer" onclick="setStatus(' + data.Id + ', ' + setStatus + ')">隐藏</span>';
                    }
                }
                ,{
                    field: 'Weight', title: '排序', align: 'center', minWidth: 110, templet: function (data) {
                        return data.Weight;
                    }
                }
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

            console.log(obj);
            switch(layEvent){
                case 'delete':
                    ajaxDel(obj.data.Id);
                    break;
                case 'update':
                    edit(obj.data.Id);
                    break;
            }
        });

        // 树形菜单
        //渲染
        var inst1 = tree.render({
            elem: '#test1'  //绑定元素
            ,edit: ['add', 'update', 'del', 'del2'] //操作节点的图标
            ,onlyIconControl: true  //是否仅允许节点左侧图标控制展开收缩
            ,click: function(obj){
                layer.msg(JSON.stringify(obj.data));
            }
            ,operate: function(obj){
                var type = obj.type; //得到操作类型：add、edit、del
                var data = obj.data; //得到当前节点的数据
                var elem = obj.elem; //得到当前节点元素

                //Ajax 操作
                var id = data.id; //得到节点索引
                if(type === 'del2'){ //增加节点
                    //返回 key 值
                    console.log("add")
                    return 123;
                } else if(type === 'update'){ //修改节点
                    console.log(elem.find('.layui-tree-txt').html()); //得到修改后的内容
                } else if(type === 'del'){ //删除节点

                };
            }
            ,data: [{
                title: '江西' //一级菜单
                ,icon: 'layui-icon-component' //一级菜单
                ,children: [{
                    title: '南昌' //二级菜单
                    ,children: [{
                        title: '高新区' //三级菜单
                        //…… //以此类推，可无限层级
                    }]
                }]
            },{
                title: '陕西' //一级菜单
                ,children: [{
                    title: '西安' //二级菜单
                }]
            }]
        });

    });
</script>

{{template "admin/layout/footer.tpl" .}}