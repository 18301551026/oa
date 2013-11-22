<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>添加节点</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>

	<script type="text/javascript">
		$(function() {
			$("#shareAddNodeForm").form({
				url : ctx + '/person/shareFileTree!addNode.action',
				onSubmit : function() {
					if ($("#shareAddNodeForm").form("validate")) {
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
						msg : '添加成功',
						title : '提示'
					});
					parent.$.modalDialog.openner_shareFileTree.tree('reload');
					parent.$.modalDialog.handler.dialog('close');
				}
			});

		})
	</script>
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