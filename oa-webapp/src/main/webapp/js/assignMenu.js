var setting = {
	check : {
		enable : true
	}
};

$(function() {
	// 关闭对话框按钮事件
	$("#closeButton").click(function() {
		$("#assignMenuDialog").dialog('close');
	});
	// 保存按钮事件
	$("#saveButton").click(function() {
		var zTree = $.fn.zTree.getZTreeObj("assignMenuTree");
		var nodes = zTree.getCheckedNodes(true);
		var roleId = $("#roleId").val();
		var param = "id=" + roleId;
		for ( var i in nodes) {
			param = param + "&ids=" + nodes[i].id
		}
		$.ajax({
			type : "POST",
			url : ctx + "/security/role!assignMenu.action",
			data : param,
			success : function(data) {
				$.messager.alert('分配菜单', '分配菜单成功');
				$("#assignMenuDialog").dialog('close');
			}
		});
	});
});

