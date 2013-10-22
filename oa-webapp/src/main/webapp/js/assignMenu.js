var setting = {
	check: {
		enable: true
	}				
};

$(function(){
	//关闭对话框按钮事件
	$("#closeButton").click(function(){
		$("#assignMenuDialog").dialog('close');
	});
	//保存按钮事件
	$("#saveButton").click(function(){
		var zTree = $.fn.zTree.getZTreeObj("assignMenuTree");
		var nodes = zTree.getCheckedNodes(true);
		var roleId = $("#roleId").val();
		var param = "id=" + roleId; 
		for (var i in nodes) {
			param = param + "&ids=" + nodes[i].id
		}
		$.ajax({
		   type: "POST",
		   url: ctx + "/security/role!assignMenu.action",
		   data: param,
		   success: function(data){
		     $.messager.alert('分配菜单','分配菜单成功');
		     $("#assignMenuDialog").dialog('close');
		   }
		});		
	});		
});

function assignMenu(id) {
	$("#roleId").val(id);	
	//初始化菜单
	$.post(ctx + '/security/menu!findCheckedMenuByRole.action', {roleId: id}, function(data){
		var nodes = eval(data);
		$.fn.zTree.destroy();
		var zTree = $.fn.zTree.init($("#assignMenuTree"), setting, nodes);
		zTree.expandAll(true);
	});
	
	$("#assignMenuDialog").dialog('open');
}