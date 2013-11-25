var assignMenuTreeSetting = {
	check : {
		enable : true
	}
};
$(function() {
	// 初始化菜单
	$.post(ctx + '/security/menu!findCheckedMenuByRole.action', {
		roleId : $("#roleId").val()
	}, function(data) {
		var assignMenuTreeNodes = eval(data);
		/* $.fn.assignMenuTree.destroy(); */
		var assignMenuTree = $.fn.zTree.init($("#assignMenuTree"),
				assignMenuTreeSetting, assignMenuTreeNodes);
		assignMenuTree.expandAll(true);
	});

	$("#assignMenuForm").form({
		onSubmit : function() {
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
					parent.$.messager.alert('分配菜单', '分配菜单成功');
					parent.$.modalDialog.handler.dialog('close');
				}
			});
			return false;
		}
	});

})
