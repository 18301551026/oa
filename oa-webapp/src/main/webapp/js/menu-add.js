$(function() {
	$("#addMenuForm").form({
		url : ctx + '/security/menu!saveMenu.action',
		onSubmit : function() {
			if ($("#addMenuForm").form("validate")) {
				return true;
			} else {
				return false;
			}
		},
		success : function(r) {
			if (!r) {
				return;
			}
			var jsonObj = jQuery.parseJSON(r);
			parent.$.modalDialog.openner_treeGrid.treegrid('append', {
				parent : jsonObj.pid,
				data : [ {
					id : jsonObj.id,
					name : jsonObj.name,
					url : jsonObj.url,
					order : jsonObj.order
				} ]

			});
			$.messager.show({
				msg : '添加成功',
				title : '提示'
			});
			parent.$.modalDialog.handler.dialog('close');
			// parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了

		}
	});
});
