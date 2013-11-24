<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>修改数据字典</title>
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
		<button type="button" class="btn btn-info" id="resetButton"
			actionUrl="${ctx}/message/dictionary!toUpdate.action?id=${id}">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/message/dictionary!save.action" method="post"
		id="editForm">
		<s:hidden name="id"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="title">字典类型：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入字典类型" cssClass="form-control validate[required]"
						id="title"></s:textfield></Td>
				<Td class="control-label"><label for="name">显示名称：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="name"
						placeholder="请输入显示名称" cssClass="form-control validate[required]"
						id="name"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="value">真正值：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="value"
						placeholder="请输入真正的值" cssClass="form-control" id="value"></s:textfield>
				</Td>
			</tr>
		</table>
	</form>
</body>
</html>
