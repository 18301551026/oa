<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>执行报销任务</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
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
	<form action="${ctx}/work/expense!performTask.action" method="post"
		id="editForm">
		<s:hidden name="taskId" value="%{#parameters.taskId}"></s:hidden>
		<s:hidden name="id"></s:hidden>
		<div class="btn-group pull-right btn-group-sm">
			<s:iterator value="#buttonList" var="v">
				<input type="submit" name="transition" class="btn btn-info"
					value='${v }'>
			</s:iterator>
		</div>
		<div class="clearfix" style="margin-bottom: 20px;"></div>

		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="taskName">任务名称：</label></Td>
				<Td class="query_input"><input type="text" readonly="readonly"
					id="taskName" value="${taskName }" class="form-control"></Td>
				<Td class="control-label"><label for="ss">申请人：</label></Td>
				<Td class="query_input"><input type="text" readonly="readonly"
					id="ss" class="form-control" value="${requestUser.userName }"></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="money">报销金额：</label></Td>
				<Td class="query_input"><s:textfield name="money"
						placeholder="请输入报销金额" cssClass="form-control validate[required]"
						id="money"></s:textfield></Td>
				<Td class="control-label"><label for="title">标题：</label></Td>
				<Td class="query_input"><s:textfield name="title"
						placeholder="请输入标题" cssClass="form-control" id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="money">报销金额：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="reason"></s:textarea>
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
