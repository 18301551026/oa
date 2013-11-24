<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>新闻添加</title>
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
	<form action="${ctx}/message/news!save.action" method="post"
		id="editForm">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="dictionarys">新闻类型：</label></Td>
				<Td class="query_input"><s:select
						cssClass="form-control validate[required]" id="dictionarys"
						placeholder="请选择新闻类型" list="dictionarys" listKey="name"
						listValue="value" name="type"></s:select></Td>
				<Td class="control-label"><label for="title">新闻标题：</label></Td>
				<Td class="query_input"><s:textfield
						cssClass="form-control validate[required]" id="title" name="title"
						placeholder="请输入新闻标题"></s:textfield></Td>
			</tr>
			<Tr>
				<Td class="control-label"><labe>内容：</label></Td>
				<Td colspan="3"><s:textarea name="content"></s:textarea></Td>
			</Tr>
		</table>
	</form>
</body>
</html>
