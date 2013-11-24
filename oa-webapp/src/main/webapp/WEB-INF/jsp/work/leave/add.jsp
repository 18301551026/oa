<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>请假单添加</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
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
	<form action="${ctx}/work/leave!save.action" method="post"
		id="editForm">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="days">请假天数：</label></Td>
				<Td class="query_input"><s:textfield name="days"
						placeholder="请输入请假天数" cssClass="form-control validate[required]"
						id="days"></s:textfield></Td>
				<Td class="control-label"><label for="startDate">开始时间：</label></Td>
				<Td class="query_input"><s:textfield name="startDate"
						placeholder="请选择开始时间" onclick="WdatePicker()" readonly="true"
						cssClass="form-control validate[required]" id="startDate"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入标题" cssClass="form-control" id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="money">请假原因：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="reason"></s:textarea>
				</Td>

			</tr>

		</table>
	</form>
</body>
</html>
