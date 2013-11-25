$(function() {
	$("#editForm").form({
		url : ctx + '/person/schedule!updateSchedule.action',
		onSubmit : function() {
			if ($("#editForm").form("validate")) {
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
			var fullCalendar = parent.$.modalDialog.fullCalendar;
			fullCalendar.fullCalendar("refetchEvents");
			parent.$.modalDialog.handler.dialog('close');
		}
	});
})
