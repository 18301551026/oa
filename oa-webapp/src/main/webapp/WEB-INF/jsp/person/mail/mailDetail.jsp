<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>邮件详情</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<body class="editBody">
	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<div class="btn-group pull-right btn-group-sm">
		<c:if test="${sendUser.id!=sessionScope.currentUser.id }">
			<button type="button" class="btn btn-info" id="saveButton">
				<span class="glyphicon glyphicon-ok"></span> 回复
			</button>
		</c:if>
		<button type="button" class="btn btn-info"
			actionUrl="${ctx }/person/receiveBox!turnToOther.action?id=${id}"
			id="turnToOther">
			<span class="glyphicon glyphicon-ok"></span> 转发
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<table class="formTable table">
		<tr>
			<Td class="control-label" style="width: 3%"><label for="title">标题：</label></Td>
			<Td class="query_input" colspan="3"><s:textfield name="title"
					readonly="true" placeholder="请输入标题" cssClass="form-control"
					id="title"></s:textfield></Td>
		</tr>
		<tr>
			<Td class="control-label" style="width: 3%"><label
				for="receiveUsersName">接收人：</label></Td>
			<Td class="query_input" colspan="3"><s:textfield
					name="receiveUsersName" placeholder="请选择接收人" readonly="true"
					cssClass="form-control pull-left" id="receiveUsersName"></s:textfield>
			</Td>
		</tr>
		<tr>
			<Td class="control-label" style="width: 3%"><label for="content">内容：</label></Td>
			<Td class="query_input" colspan="3">
				<div class="readyonlyTextarea" style="height: 130px;">${content }</div>
			</Td>
		</tr>
	</table>
	<c:if test="${sendUser.id!=sessionScope.currentUser.id }">
		<form action="${ctx}/person/draftBox!save.action" method="post"
			id="editForm">
			<input type="hidden" name="receiveUsersName" value="${sendUserName}" />
			<s:hidden name="receiveUserIds" value="%{sendUser.id}"></s:hidden>
			<table class="formTable table">
				<tr>
					<Td class="control-label" style="width: 3%"><label for="title">回复标题：</label></Td>
					<Td class="query_input" colspan="3"><input type="text"
						name="title" class="form-control validate[required]" id="title"
						value="回复${sendUserName}" placeholder="请输入标题" /></Td>
				</tr>
				<tr>
					<Td class="control-label" style="width: 3%"><label
						for="content">内容：</label></Td>
					<Td class="query_input" colspan="3"><textarea name="content"></textarea>
					</Td>
				</tr>
			</table>
		</form>
	</c:if>

</body>
</html>