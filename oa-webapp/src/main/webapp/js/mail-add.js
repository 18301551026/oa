$(function() {
	$("#selectReceiveUsersButton")
			.click(
					function() {
						parent.$
						.modalDialog({
							title : "选择收件人",
							width : 300,
							height : 500,
							href : ctx
									+ "/person/sendBox!toSelectReceiveUsers.action",
							buttons : [
									{
										text : '全体人员',
										handler : function() {
											$("#ids").val(0);
											$("#receiveUsersName").val(
													"全体人员");
											parent.$.modalDialog.handler
													.dialog('close');
										}
									},
									{
										text : '确定',
										iconCls : 'icon-save',
										handler : function() {
											var ids = parent.$.modalDialog.handler
													.find('#ids');
											var receivedUserNames = parent.$.modalDialog.handler
													.find('#receiveUsersName');
											$("#receiveUsersName").val(
													receivedUserNames
															.val());
											$("#ids").val(ids.val());
											parent.$.modalDialog.handler
													.dialog('close');
										}
									} ]
						});
					})
	$("#addAttach")
			.click(
					function() {
						var temp = $(this)
								.before(
										'<input type="file" class="pull-left" name="attach" /><input class="btn btn-info btn-xs pull-left deleteAttach" value="删除" type="button" />');
					})
})