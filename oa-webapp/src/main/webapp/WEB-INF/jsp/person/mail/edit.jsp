<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>新建邮件</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript">
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
														$("#receiveUsersName")
																.val("全体人员");
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
														$("#receiveUsersName")
																.val(
																		receivedUserNames
																				.val());
														$("#ids")
																.val(ids.val());
														parent.$.modalDialog.handler
																.dialog('close');
													}
												} ]
									});
						})

	})
</script>

<body class="editBody">
	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<div class="btn-group pull-right btn-group-sm">
		<button type="button" class="btn btn-info" id="saveButton">
			<span class="glyphicon glyphicon-ok"></span> 发送
		</button>
		<button type="button" class="btn btn-info" id="otherButton"
			actionUrl="${ctx }/person/sendBox!saveToDraft.action">
			<span class="glyphicon glyphicon-ok"></span> 保存
		</button>
		<button type="button" class="btn btn-info" id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/person/sendBox!save.action" method="post"
		id="editForm">
		<s:hidden name="id"></s:hidden>
		<s:hidden name="receiveUserIds" id="ids"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label" style="width: 3%"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入标题" cssClass="form-control validate[required]"
						id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label" style="width: 3%"><label
					for="receiveUsersName">接收人：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="receiveUsersName" placeholder="请选择接收人" readonly="true"
						cssClass="form-control pull-left validate[required]"
						cssStyle="width: 95%;" id="receiveUsersName"></s:textfield>
					<button class="btn btn-info btn-xs pull-right" actionId="${id }"
						id="selectReceiveUsersButton" style="margin-top: 2px;">选择</button></Td>
			</tr>
			<tr>
				<Td class="control-label" style="width: 3%"><label
					for="content">内容：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="content"
						id="content"></s:textarea></Td>
			</tr>
		</table>
	</form>
</body>
</html>