$(function() {
	$("#uploadShareFileForm").form({
		url : ctx + '/person/upload!upload.action',
		onSubmit : function() {
			if ($("#uploadShareFileForm").form("validate")) {
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
			parent.$.modalDialog.openner_queryForm.submit();
			console.info();
			parent.parent.$.modalDialog.handler.dialog('close');
		}
	});
})