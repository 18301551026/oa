function confirmCanDownloadUsersFn(fileId, canIds) {
	$.ajax({
		type : "POST",
		url : ctx + "/person/upload!confirmCanDownloadUsers.action",
		data : "id=" + fileId + "&canDownloadUserIds=" + canIds,
		success : function(msg) {
			parent.parent.$.modalDialog.handler.dialog('close');
			parent.$.messager.alert('设置权限', '设置成功');
		}
	});
}
$(function() {
	$(".setCanDownloadButton")
			.click(
					function() {
						var fileId = $(this).attr("fileId");
						parent.parent.$
								.modalDialog({
									title : "设置可下载人员",
									width : 300,
									height : 500,
									href : $(this).attr("actionUrl"),
									buttons : [
											{
												text : '全体人员',
												handler : function() {
													confirmCanDownloadUsersFn(
															fileId, 0);
												}
											},
											{
												text : '确定',
												iconCls : 'icon-save',
												handler : function() {
													var ids = parent.parent.$.modalDialog.handler
															.find('#ids').val();
													console.info(ids + "\t"
															+ fileId);
													confirmCanDownloadUsersFn(
															fileId, ids);
												}
											} ]
								});
					})
	$("#uploadFileButton")
			.click(
					function() {

						parent.parent.$
								.modalDialog({
									title : "上传资源",
									width : 340,
									height : 140,
									href : ctx
											+ "/person/upload!toUpload.action?fileTree.id="
											+ $("#fileTreeId").val(),
									buttons : [
											{
												text : '上传',
												iconCls : 'icon-save',
												handler : function() {
													parent.parent.$.modalDialog.openner_queryForm = $("#queryForm");
													var f = parent.parent.$.modalDialog.handler
															.find('#uploadShareFileForm');
													f.submit();
												}
											},
											{
												text : '取消',
												iconCls : 'icon-cancel',
												handler : function() {
													parent.parent.$.modalDialog.handler
															.dialog('close');
												}
											} ]
								});
					})
})