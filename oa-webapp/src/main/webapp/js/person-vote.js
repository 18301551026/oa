$(function() {
	$("#voteForm").form({
		url : ctx + '/person/vote!vote.action',
		onSubmit : function() {
			var ids = $("input:checked");
			if (ids.length == 0) {
				$.messager.alert("提示", "请选择投票项");
				return false;
			}
			return true;
		},
		success : function(r) {
			$.messager.show({
				msg : '投票成功',
				title : '提示'
			});
			parent.$.modalDialog.handler.dialog('close');
		}

	});
})