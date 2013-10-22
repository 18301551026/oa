<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>执行报销任务</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
	<%@ include file="/common/include-jquery-kindeditor.jsp" %>
    <script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
</head>

<body>
	<form id="editForm" class="form-horizontal" action="${ctx}/work/expense!performTask.action" method="post">
		<s:hidden name="taskId" value="%{#parameters.taskId}"></s:hidden>
	    <s:hidden name="id"></s:hidden>	

	<div id="navigatorDiv">
		<s:iterator value="#buttonList" var="v">
			<input type="submit" name="transition" class="button positive" value="${v }">
		</s:iterator>
	</div>
	
	<div id="editDiv">
		<fieldset>
		<legend><small>执行报销任务</small></legend>
		<table >
		  <tr>
			<td width="20%"><label>任务名称：</label></td>
			<td width="30%" style="color: blue">
			  ${taskName }
			</td>
			<td width="20%"><label>申请人：</label></td>
			<td  style="color: blue">
			  ${requestUser.userName }
			</td>
		  </tr>
			<tr>				
				<td><label>报销金额：</label></td>
				<td colspan="3">
					<s:textfield name="money" readonly="true"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>标题：</label></td>
				<td colspan="3">
					<s:textfield name="title"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>原因：</label></td>
				<td colspan="3">
					<div class="show-html">${reason }</div>
				</td>
			</tr>
		  <!-- 审批意见 -->
		  <tr>
			<td >审批意见</td>
			<td colspan="3">
			  <s:textarea name="comment" cssStyle="width:100%; height:200px;"></s:textarea>
			</td>
		  </tr>	 
		  <c:forEach items="${commentList}" var="c">
		  <tr>
			<td >${c.taskName }</td>
			<td  colspan="3" style="color: blue;">
				${c.comment }
			</td>
		  </tr>	  
		  </c:forEach>

		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>
