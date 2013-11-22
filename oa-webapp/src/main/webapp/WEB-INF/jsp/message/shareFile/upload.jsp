<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>上传资源</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<script type="text/javascript">
		$(function() {
			$("#uploadShareFileForm").form({
				url : ctx + '/person/shareFile!upload.action',
				onSubmit : function() {
					if ($("#uploadShareFileForm").form("validate")) {
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
					parent.$.modalDialog.openner_queryForm.submit();
					console.info();
					parent.parent.$.modalDialog.handler.dialog('close');
				}
			});
		})
	</script>
	<s:form action="/person/shareFile!upload.action" method="post"
		id="uploadShareFileForm" enctype="multipart/form-data"
		cssStyle="margin:15px">
		<s:file name="fileContent" cssClass="easyui-validatebox"
			data-options="required:true" ></s:file>
		<s:hidden name="fileTree.id"></s:hidden>
	</s:form>
</body>
</html>