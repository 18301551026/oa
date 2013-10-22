<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>添加通讯录</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/edit.js"></script>
</head>

<body>

	<div id="navigatorDiv">
	  	<button type="button" id="saveButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/filesave.png" alt=""/> 保存
  	  	</button>
	  	<button type="button" id="resetButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/reload.png" alt=""/> 重置
  	  	</button>
	  	<button type="button" id="backButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/undo.png" alt=""/> 返回
  	  	</button>
	</div>
	
	<div id="editDiv">
	<form id="editForm" class="form-horizontal" action="${ctx}/person/address!save.action" method="post">
		<input type="hidden" name="type" value="${param.type }">
		<fieldset>
		<legend><small>通讯录添加</small></legend>
		<table >
			<tr>
				<td width="20%"><label>中文名：</label></td>
				<td >
					<s:textfield name="firstName"></s:textfield>
				</td>
				<td width="20%"><label>英文名：</label></td>
				<td >
					<s:textfield name="secondName"></s:textfield>
				</td>				
			</tr>
			<tr>
				<td width="20%"><label>固定电话：</label></td>
				<td >
					<s:textfield name="fixedPhone"></s:textfield>
				</td>
				<td width="20%"><label>手机：</label></td>
				<td >
					<s:textfield name="mobilPhone"></s:textfield>
				</td>				
			</tr>	
			<tr>
				<td width="20%"><label>公司名称：</label></td>
				<td colspan="3">
					<s:textfield name="companyName"></s:textfield>
				</td>				
			</tr>							
		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>
