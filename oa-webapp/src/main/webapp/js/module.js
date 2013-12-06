$(function() {
	$("#selectCanWatchUsersButton")
			.click(
					function() {
						var url;
						if ($(this).attr("actionId")) {
							url = ctx
									+ "/work/module!toSelectCanWatchUsers.action?id="+$(this).attr("actionId");
						} else {
							url = ctx
									+ "/work/module!toSelectCanWatchUsers.action";
						}
						parent.$
								.modalDialog({
									title : "请选择可见人员",
									width : 300,
									height : 500,
									href : url,
									buttons : [
											{
												text : '全体人员',
												handler : function() {
													$("#ids").val(0);
													$("#canWathUserNames").val(
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
													$("#canWathUserNames").val(
															receivedUserNames
																	.val());
													$("#ids").val(ids.val());
													parent.$.modalDialog.handler
															.dialog('close');
												}
											} ]
								});
					})
})
