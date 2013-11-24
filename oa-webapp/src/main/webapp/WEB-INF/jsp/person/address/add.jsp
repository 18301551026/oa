<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>通讯录添加</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
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
		<button type="button" class="btn btn-info" id="saveButton">
			<span class="glyphicon glyphicon-ok"></span> 保存
		</button>
		<button type="button" class="btn btn-info" id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/person/address!save.action" method="post"
		id="editForm">
		<input type="hidden" name="type" value="${param.type }">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="firstName">中文名：</label></Td>
				<Td class="query_input"><s:textfield name="firstName"
						placeholder="请输入中文名" cssClass="form-control validate[required]"
						id="firstName"></s:textfield></Td>
				<Td class="control-label"><label for="secondName">英文名：</label></Td>
				<Td class="query_input"><s:textfield name="secondName"
						placeholder="请输入英文名" cssClass="form-control validate[required]"
						id="secondName"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="fixedPhone">固定电话：</label></Td>
				<Td class="query_input"><s:textfield name="fixedPhone"
						placeholder="请输入固定电话" cssClass="form-control validate[required]"
						id="fixedPhone"></s:textfield></Td>
				<Td class="control-label"><label for="mobilPhone">手机：</label></Td>
				<Td class="query_input"><s:textfield name="mobilPhone"
						placeholder="请输入手机" cssClass="form-control validate[required]"
						id="mobilPhone"></s:textfield></Td>
			</tr>
			<Tr>
				<Td class="control-label"><label for="companyName">公司名称：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="companyName" placeholder="请输入公司名称" cssClass="form-control"
						id="companyName"></s:textfield></Td>
			</Tr>
		</table>
	</form>
</body>
</html>
