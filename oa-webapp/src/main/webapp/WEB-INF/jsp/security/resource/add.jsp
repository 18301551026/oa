<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>修改资源</title>
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
	<form id="editForm" class="form-horizontal" action="${ctx}/security/resource!save.action" method="post">
		<s:hidden name="id"></s:hidden>
		<fieldset>
		<legend><small>资源修改</small></legend>
		<table >
			<tr>				
				<td width="20%"><label>访问地址：</label></td>
				<td>
					<s:textfield name="url"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>

</body>
</html>