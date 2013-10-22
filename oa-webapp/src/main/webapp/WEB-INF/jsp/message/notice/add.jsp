<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>添加通知</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
	<%@ include file="/common/include-jquery-kindeditor.jsp" %>
    <script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
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
	<form id="editForm" class="form-horizontal" action="${ctx}/message/notice!save.action" method="post">
		<fieldset>
		<legend><small>通知添加</small></legend>
		<table >
			<tr>
				<td width="20%"><label>通知类型：</label></td>
				<td >
					<s:select list="dictionarys" listKey="name" listValue="value" name="type"></s:select>
				</td>
			</tr>
			<tr>				
				<td><label>通知标题：</label></td>
				<td>
					<s:textfield name="title"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td><label>内容：</label></td>
				<td>
					<s:textarea name="content" cssClass="htmlarea"></s:textarea>
				</td>
			</tr>			
		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>
