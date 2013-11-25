$(function() {
	$("#addOption")
			.click(
					function() {
						var temp = $(this)
								.after(
										'<input name="voteOptions" class="form-control validate[required] pull-left" placeholder="请输入投票选项"  style="width:95%"  /><input class="btn btn-info btn-xs pull-right deleteOption" value="删除" type="button" />');
					})
	$("#selectVoteAreaButton")
			.click(
					function() {
						parent.$
								.modalDialog({
									title : "选择投票范围",
									width : 300,
									height : 500,
									href : ctx
											+ "/work/voteSubject!toSelectVoteArea.action",
									buttons : [
											{
												text : '全体人员',
												handler : function() {
													$("#ids").val(0);
													$("#canVoteUsersName").val(
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
													$("#canVoteUsersName").val(
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
