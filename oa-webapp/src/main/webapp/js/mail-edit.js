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
											+ "/person/draftBox!toSelectReceiveUsers.action",
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
										'<s:file name="attach" cssClass="pull-left"></s:file><input class="btn btn-info btn-xs pull-left deleteAttach" value="删除" type="button" />');
					})
	$(".deleteAttachFromDb").click(function() {
		var pre = $(this).prev();
		pre.remove();
		$(this).remove();
		var id = $(this).attr("deleteId");
		$.ajax({
			type : "POST",
			url : ctx + "/person/draftBox!deleteAtt.action",
			data : "attId=" + id,
			success : function(msg) {

			}
		});

	})
})