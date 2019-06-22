{{template "admin/layout/header.tpl" .}}

<blockquote class="layui-elem-quote">
    <a class="layui-btn layui-btn-sm layui-btn-danger batchDell" href="javascript:;" onclick="add()"><i class="layui-icon">&#xe654;</i>添加</a>
    <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新" style="float:right"><i class="layui-icon">&#xe669;</i>刷新</a>
</blockquote>
<fieldset class="layui-elem-field" style="padding-right: 5px;">
    <legend><b>test列表</b></legend>
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
    <div class="layui-field-box layui-form">
        <form action="" name="mainform" method="post">
            <table class="layui-table" lay-size="sm" style="">
                <thead>
                <tr>
                    <th style="width: 30px;"><input type="checkbox" lay-filter="allselector" lay-skin="primary" id="qx"></th>
                    <th>ID</th>
                    <th>头像</th>
                    <th>排序</th>
                    <th>添加时间</th>
                    <th>修改时间</th>
                    <th>单头像</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {volist name="data" id="v"}
                <tr>
                    <td><input type="checkbox" name="ids[]" value="{$v['id']}" lay-skin="primary"></td>
                    <td align="center">{$v.id}</td><?php $field_images = explode(",", $v["tx_images"]); ?><td align="center">{if condition="!empty($field_images)"}
                        {volist name="$field_images" key="k2" id="v2"}
                        {if condition="$k2 <= 3"}
                        <a href="{$v2}" target="_blank"><img src="{$v2}" alt="" style="width: 110px;height: auto;max-height: 85px;"></a>
                        {else /}
                        .
                        {/if}
                        {/volist}
                        {/if}</td><td align="center"><input type="text" name="sortrank{$v.id}" value="{$v.weight}" style="width:30px;" autocomplete="off"></td><td align="center">{$v.addtime}</td><td align="center">{$v.edittime}</td><td align="center">
                        {if condition="!empty($v.tx2_image)"}
                        <a href="{$v.tx2_image}" target="_blank"><img src="{$v.tx2_image}" alt="" style="width: 110px;height: auto;max-height: 85px;"></a>
                        {/if}
                    </td>                    <td align="center">
                        <a href="javascript:;" onclick="edit('{$v.id}')" data-name="" data-opt="edit" class="layui-btn layui-btn-xs">编辑</a>
                        <a href="javascript:;" onclick="ajaxDel('{$v.id}')" data-id="1" data-opt="del" class="layui-btn layui-btn-danger layui-btn-xs">删除</a>
                    </td>
                </tr>
                {/volist}
                <tr>
                    <td colspan="8" align="center">
                        {$data->render()}
                        第<span class="pagelink_cur_page">{:input('get.page') ? input('get.page') : 1}</span>/<span class="pagelink_all_page"><?php echo ceil(($count / $pagesize)); ?></span>页&nbsp;每页<span class="pagelink_pagesize">{$pagesize}</span>条&nbsp;共<span class="pagelink_all_rec">{$count}</span>条
                    </td>
                </tr>
                <tr>
                    <td colspan="8" align="center">
                        <a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="ajaxDelAll()">批量删除</a>
                        <a class="layui-btn layui-btn-xs layui-btn-primary" onclick="upRankAll()">排序</a>                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</fieldset>

<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
        form.on('checkbox(allselector)', function(data){
            var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
            child.each(function(index, item){
                item.checked = data.elem.checked;
            });
            form.render('checkbox');
        });

    });
</script>

{{template "admin/layout/footer.tpl" .}}