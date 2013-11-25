<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>新建邮件</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>

</head>


<body class="editBody">
	<script type="text/javascript" src="${ctx }/js/mail-add.js"></script>

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
		id="editForm" enctype="multipart/form-data">
		<s:hidden name="receiveUserIds" id="ids"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label" style="width: 3%"><label
					for="receiveUsersName">接收人：</label></Td>
				<Td class="query_input" colspan="3"><input
					name="receiveUsersName" placeholder="请选择接收人" readonly="readonly"
					class="form-control pull-left validate[required]"
					style="width: 95%;" id="receiveUsersName" />
					<button class="btn btn-info btn-xs pull-right"
						id="selectReceiveUsersButton" style="margin-top: 2px;">选择</button></Td>
			</tr>
			<tr>
				<Td class="control-label" style="width: 3%"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入标题" cssClass="form-control validate[required]"
						id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label" style="width: 3%"><label>附件：</label></Td>
				<Td class="query_input" colspan="3"><s:file name="attach"
						cssClass="pull-left"></s:file><input
					class="btn btn-info btn-xs pull-left deleteAttach" value="删除"
					type="button" /> <input class="btn btn-info btn-xs pull-right"
					id="addAttach" value="添加" type="button" /></Td>
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