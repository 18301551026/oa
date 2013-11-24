$(function() {
	$("#shareUpdateNodeForm").form({
		url : ctx + '/person/shareFileTree!updateNode.action',
		onSubmit : function() {
			if ($("#shareUpdateNodeForm").form("validate")) {
				return true;
			} else {
				return false;
			}
		},
		success : function(r) {
			if (!r) {
				return;
			}
			$.messager.show({
				msg : '修改成功',
				title : '提示'
			});
			parent.$.modalDialog.openner_shareFileTree.tree('reload');
			parent.$.modalDialog.handler.dialog('close');
		}
	});

})