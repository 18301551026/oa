$(function() {
	$("#shareAddNodeForm").form({
		url : ctx + '/person/shareFileTree!addNode.action',
		onSubmit : function() {
			if ($("#shareAddNodeForm").form("validate")) {
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
				msg : '添加成功',
				title : '提示'
			});
			parent.$.modalDialog.openner_shareFileTree.tree('reload');
			parent.$.modalDialog.handler.dialog('close');
		}
	});

})