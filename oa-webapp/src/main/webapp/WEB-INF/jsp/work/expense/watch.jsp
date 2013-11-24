<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>查看报销单</title>
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

<body  class="editBody">

	<%-- <div id="navigatorDiv">
	  	<button type="button" id="backButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/undo.png" alt=""/> 返回
  	  	</button>
	</div>
	
	<div id="editDiv">
		<fieldset>
		<legend><small>报销单查看</small></legend>
		<table >
		  <tbody>
			<tr>				
				<td width="20%"><label>报销金额：</label></td>
				<td>
					<s:textfield name="money" readonly="true"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>报销原因：</label></td>
				<td>
					<div class="show-html">${reason }</div>
				</td>
			</tr>
			  <!-- 审批意见 -->
			  <c:forEach items="${commentList}" var="c">
			  <tr>
				<td>${c.taskName }</td>
				<td style="color: blue;">
					${c.comment }
				</td>
			  </tr>	  
			  </c:forEach>
		  </tbody>
		</table>
		</fieldset>
	</div>
 --%>
 	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<form id="editForm" action="${ctx}/work/expense!performTask.action"
		method="post">
		<div class="clearfix" style="margin-bottom: 20px;"></div>
		<s:hidden name="taskId" value="%{#parameters.taskId}"></s:hidden>
		<s:hidden name="id"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="money">报销金额：</label></Td>
				<Td class="query_input"><s:textfield name="money"
						readonly="true" cssClass="form-control" id="money"></s:textfield></Td>
				<Td class="control-label"><label for="title">标题：</label></Td>
				<Td class="query_input"><s:textfield name="title" id="title"
						cssClass="form-control" readonly="true"></s:textfield></Td>
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
