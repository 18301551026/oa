$(function() {
	$("#addOption")
			.click(
					function() {
						$(this).parent().children().last().after('<input name="voteOptions" class="form-control validate[required] pull-left" placeholder="请输入投票选项"  style="width:95%;;margin-bottom: 2px"  /><input class="btn btn-info btn-xs pull-right deleteOption" value="删除" style="margin-top: 2px;" type="button" />');
					})
	$("#selectVoteAreaButton")
			.click(
					function() {
						var url;
						if ($(this).attr("actionId")) {
							url = ctx
									+ "/work/voteSubject!toSelectVoteArea.action?id="
									+ $(this).attr("actionId")
						} else {
							url = ctx
									+ "/work/voteSubject!toSelectVoteArea.action";
						}
						parent.$
								.modalDialog({
									title : "选择投票范围",
									width : 300,
									height : 500,
									href : url,
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
	$(".updateOption").click(function() {
		var url = $(this).attr("deleteAction");
		var updateId = $(this).attr("updateId");
		var optionText = $($(this).prevAll()[2]).val();
		$.ajax({
			type : "POST",
			url : url,
			data : "optionId=" + updateId + "&optionText=" + optionText,
			success : function(msg) {
				alert("修改成功");
			}
		});
	})
})
