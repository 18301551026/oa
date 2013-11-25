<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>添加节点</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>


</head>
<body>
	<script type="text/javascript" src="${ctx }/js/shareFile-addNode.js"></script>

	<form id="shareAddNodeForm" action="" method="post">
		<table align="center" style="margin-top: 4px;">
			<Tr>
				<Td>节点名称：</Td>
				<td><input type="text" class="easyui-validatebox"
					data-options="required:true" name="text" style="width: 200px;" /></td>
			</Tr>
			<tr>
				<TD><input type="hidden" name="pid" value="${id }" /></TD>
			</tr>
		</table>
	</form>
</body>
</html>