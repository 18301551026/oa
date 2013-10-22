<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>添加数据字典</title>
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
	<form id="editForm" class="form-horizontal" action="${ctx}/message/dictionary!save.action" method="post">
		<fieldset>
		<legend><small>数据字典添加</small></legend>
		<table >
			<tr>
				<td width="20%"><label>字典类型：</label></td>
				<td >
					<s:textfield name="type"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td><label>显示名称：</label></td>
				<td>
					<s:textfield name="name"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td><label>真正值：</label></td>
				<td>
					<s:textfield name="value"></s:textfield>
				</td>
			</tr>			
		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>
