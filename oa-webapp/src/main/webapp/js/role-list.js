function assignMenu(id) {
	parent.$.modalDialog({
		title : "分配菜单",
		width : 260,
		height : 500,
		href : ctx + '/security/role!toAssignMenu.action?id=' + id,
		buttons : [ {
			text : '保存',
			iconCls : 'icon-save',
			handler : function() {
				var f = parent.$.modalDialog.handler.find('#assignMenuForm');
				f.submit();

			}
		}, {
			text : '关闭',
			iconCls : 'icon-cancel',
			handler : function() {
				parent.$.modalDialog.handler.dialog('close');
			}
		} ]
	});
}