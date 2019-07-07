{{.t.BottomJs}}

<script>
    //定义模块
    //js转换驼峰命名
    var controller = "{{.Request.Controller}}";
    // controller = controller.replace(/([A-Z])/g,"_$1").toLowerCase();
    // if (controller.indexOf("_") == 0) {
    //     controller = controller.substring(1);
    // }
    model = "/{{.Request.Module}}/" + controller + "/";

    /**
     * 数据添加
     */
    function add(id = 0){
        layer.open({
            type: 2,
            title: '数据添加',
            shadeClose: true,
            shade: 0.8,
            area: ['90%', '90%'],
            content: model + "add" + "?id=" + id,
            end:function()
            {}
        });
    }

    /**
     * 数据修改
     */
    function edit(id){
        layer.open({
            type: 2,
            title: '数据修改',
            shadeClose: true,
            shade: 0.8,
            area: ['90%', '90%'],
            content: model + "edit?id=" + id,
            end:function()
            {}
        });
    }

    /**
     * 数据删除
     */
    function del(id){
        layer.confirm('是否删除?', {icon: 3, title:'提示'}, function(index){
            ajaxDel(id);
            layer.close(index);
        });
    }

    /**
     * 数据批量删除
     */
    function dels(){
        layer.confirm('是否批量删除?', {icon: 3, title:'提示'}, function(index){
            document.form1.action="dels";
            document.form1.submit();
            layer.close(index);
        });
    }

    /**
     * 数据查看
     */
    function show(id)
    {
        layer.open({
            type: 2,
            title: '数据查看',
            shadeClose: true,
            shade: 0.8,
            area: ['90%', '90%'],
            content: model + "show/id/" + id,
            end:function()
            {}
        });
    }

    /**
     * 数据添加操作提交
     */
    function ajaxAdd()
    {
        $.ajax({
            url:model + "ajaxAdd",
            type:"POST",
            dataType:"json",
            data: $("#mainform").serialize(),
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("parent.layer.close(parent.layer.getFrameIndex(window.name));window.parent.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    /**
     * 数据修改操作提交
     */
    function ajaxEdit()
    {
        $.ajax({
            url:model + "ajaxEdit",
            type:"POST",
            dataType:"json",
            data: $("#mainform").serialize(),
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("parent.layer.close(parent.layer.getFrameIndex(window.name));window.parent.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    /**
     * 删除提示
     */
    function ajaxDel(id)
    {
        layer.confirm('是删除?', {icon: 3, title:'提示'}, function(index){
            $.ajax({
                url:model + "ajaxDel",
                type:"get",
                dataType:"json",
                data: {'id':id},
                success:function(re)
                {
                    if (re.code == "1") {
                        layer.msg(re.msg, {icon: 1});
                        setTimeout("window.location.reload();",1000);
                    } else {
                        layer.msg(re.msg, {icon: 2});
                    }
                }
            })
            layer.close(index);
        });
    }


    /**
     * 数据修改操作提交2
     * 针对于没有父页面的操作，刷新自己
     */
    function ajaxEditAll()
    {
        $.ajax({
            url:model + "ajaxEditAll",
            type:"POST",
            dataType:"json",
            data: $("#mainform").serialize(),
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("javascript:location.replace(location.href);",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }



    /**
     * 软删除
     */
    function ajaxHidden(id)
    {
        $.ajax({
            url:model + "ajaxHidden",
            type:"GET",
            dataType:"json",
            data: {"id":id},
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("window.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    /**
     * 批量隐藏
     */
    function ajaxHiddenAll()
    {
        var data = $("[name='mainform']").serialize();
        $.ajax({
            url:model + "ajaxHiddenAll",
            type:"post",
            dataType:"JSON",
            data:data,
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("window.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    /**
     * 批量删除
     */
    function ajaxDelAll()
    {
        layer.confirm('是删除?', {icon: 3, title:'提示'}, function(index){
            var data = $("[name='mainform']").serialize();
            $.ajax({
                url:model + "ajaxDelAll",
                type:"post",
                dataType:"JSON",
                data:data,
                success:function(re)
                {
                    if (re.code == "1") {
                        layer.msg(re.msg, {icon: 1});
                        setTimeout("window.location.reload();",1000);
                    } else {
                        layer.msg(re.msg, {icon: 2});
                    }
                }
            })
            layer.close(index);
        });
    }

    /**
     * 批量删除--来自动态表格
     */
    function ajaxDelAll_table(ids)
    {
        layer.confirm('是删除?', {icon: 3, title:'提示'}, function(index){
            $.ajax({
                url:model + "ajaxDelAll",
                type:"post",
                dataType:"JSON",
                data:{ids:ids},
                success:function(re)
                {
                    if (re.code == "1") {
                        layer.msg(re.msg, {icon: 1});
                        setTimeout("window.location.reload();",1000);
                    } else {
                        layer.msg(re.msg, {icon: 2});
                    }
                }
            })
            layer.close(index);
        });
    }

    /**
     * 更新排序
     */
    function upRankAll()
    {
        //name="sortrank+id" value="v.weight"  HTML
        var data = $("[name='mainform']").serialize();
        $.ajax({
            url:model + "uprankall",
            type:"post",
            dataType:"JSON",
            data:data,
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("window.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    /**
     * AJAX删除附件
     * @param dir
     */
    function ajaxDelImg(dir, obj)
    {
        $.ajax({
            url:"{:url('tool/ajaxDelFile')}",
            type:"get",
            dataType:"JSON",
            data:{"file":dir},
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    // 删除input路径
                    var name = $(obj).parent().parent().attr("id");
                    var end = name.indexOf("_input");
                    //console.log("%cend="+end,"color:red");
                    //console.log($(obj).parent().parent());
                    name = name.substring(9,end);
                    console.log("%cname="+name,"color:#f60");
                    var v = $("[name='"+name+"']").val();
                    //console.log($("[name='"+name+"']"));
                    //console.log("%cv="+v,"color:#450");
                    v = v.replace(","+dir, "");
                    v = v.replace(dir, "");
                    // 过滤首张图去掉后的 逗号
                    if(v.substr(0,1) == ","){
                        v = v.substring(1);
                    }
                    //console.log(v);
                    $("[name='"+name+"']").val(v);
                    // 移除图片盒子
                    $(obj).parent().remove();
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

    function showFileList(obj)
    {
        layer.open({
            type: 2,
            title: '很多时候，我们想最大化看，比如像这个页面。',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '600px'],
            content: "{:url('tool/showFileList')}"
        });
    }

    function setStatus(id, status) {
        $.ajax({
            url:"/{{.Request.Module}}/{{.Request.Controller}}/setStatus",
            type:"get",
            dataType:"JSON",
            data:{id:id,status:status},
            success:function(re)
            {
                if (re.code == "1") {
                    layer.msg(re.msg, {icon: 1});
                    setTimeout("window.location.reload();",1000);
                } else {
                    layer.msg(re.msg, {icon: 2});
                }
            }
        })
    }

</script>
<script src="/static/admin/js/base.js"></script>
</body>
</html>