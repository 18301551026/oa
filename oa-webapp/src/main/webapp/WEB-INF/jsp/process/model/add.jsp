<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>添加模型</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<%@ include file="/common/include-jquery.jsp"%>
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
	<form id="editForm" class="form-horizontal" action="${ctx}/process/model!add.action" method="post">
		<fieldset>
		<legend><small>添加模型</small></legend>
		<table >
			<tr>
				<td width="20%"><label>名称(不支持中文)：</label></td>
				<td >
					<s:textfield name="name"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td><label>key(不支持中文)：</label></td>
				<td>
					<s:textfield name="key"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td><label>描述：</label></td>
				<td>
					<s:textfield name="description"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>
