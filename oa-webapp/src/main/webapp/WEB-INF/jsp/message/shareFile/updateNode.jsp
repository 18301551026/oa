<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>编辑节点</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	</style>
	<script type="text/javascript">
		$(function() {
			$("#shareUpdateNodeForm").form({
				url : ctx + '/person/shareFileTree!updateNode.action',
				onSubmit : function() {
					if ($("#shareUpdateNodeForm").form("validate")) {
						return true;
					} else {
						return false;
					}
				},
				success : function(r) {
					if (!r) {
						return;
					}
					$.messager.show({
						msg : '修改成功',
						title : '提示'
					});
					parent.$.modalDialog.openner_shareFileTree.tree('reload');
					parent.$.modalDialog.handler.dialog('close');
				}
			});

		})
	</script>
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