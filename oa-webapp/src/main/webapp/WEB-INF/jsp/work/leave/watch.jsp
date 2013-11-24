<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>查看请假表单</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
</head>

<body class="editBody">
	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<form id="editForm" action="${ctx}/work/leave!performTask.action"
		method="post">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="days">请假天数：</label></Td>
				<Td class="query_input"><s:textfield name="days"
						readonly="true" cssClass="form-control" id="days"></s:textfield></Td>
				<Td class="control-label"><label for="startDate">开始时间：</label></Td>
				<Td class="query_input"><s:textfield name="startDate"
						id="startDate" cssClass="form-control" readonly="true"></s:textfield>
				</Td>
			</tr>

			<tr>
				<Td class="control-label"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						readonly="true" cssClass="form-control"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="money">原因：</label></Td>
				<Td class="query_input" colspan="3">
					<div class="readyonlyTextarea">${reason }</div>
				</Td>

			</tr>
			<c:forEach items="${commentList}" var="c">
				<tr>
					<Td class="control-label"><label>${c.taskName }：</label></Td>
					<Td class="query_input" colspan="3">
						<div class="readyonlyTextarea">${c.comment }</div>
					</Td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>
