<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>上传资源</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>

</head>
<body>
	<script type="text/javascript" src="${ctx }/js/shareFile-update.js"></script>
	
	<s:form action="/person/upload!upload.action" method="post"
		id="uploadShareFileForm" enctype="multipart/form-data"
		cssStyle="margin:15px">
		<s:file name="fileContent" cssClass="easyui-validatebox"
			data-options="required:true" ></s:file>
		<s:hidden name="fileTree.id"></s:hidden>
	</s:form>
</body>
</html>