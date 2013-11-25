<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>编辑节点</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>

</head>
<body>
	<script type="text/javascript" src="shareFile-updateNode.js"></script>

	<form id="shareUpdateNodeForm" action="" method="post"
		style="margin-top: 5px;">
		<table align="center">

			<Tr>
				<Td>节点名称：</Td>
				<td><s:textfield cssClass="easyui-validatebox"
						data-options="required:true" name="text" style="width: 200px;"></s:textfield></td>
			</Tr>
			<tr>
				<TD><s:hidden name="id"></s:hidden></TD>
			</tr>
		</table>
	</form>
</body>
</html>