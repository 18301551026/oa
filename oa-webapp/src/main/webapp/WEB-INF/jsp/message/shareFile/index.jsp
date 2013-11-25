<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>共享文件</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>

<style type="text/css">
.layout-panel-west .panel-header {
	border-top: 0px;
	border-left: 0px;
}

.layout-panel-west .panel-body {
	border-left: 0px;
}
</style>

</head>
<s:hidden name="status" id="status"></s:hidden>
<div id="shareContextMenu" class="easyui-menu">
	<div title="添加" data-options="iconCls:'icon-add'" id="addShareNode">添加节点</div>
	<div title="删除" data-options="iconCls:'icon-remove'"
		id="deleteShareNode">删除节点</div>
	<div title="修改" data-options="iconCls:'icon-edit'" id="updateShareNode">修改节点</div>
</div>

<body class="easyui-layout" data-options="border:false">
	<script type="text/javascript" src="${ctx }/js/shareFile-index.js"></script>

	<div data-options="region:'west',title:'资料分类',split:true"
		style="width: 120px;">
		<ul id="shareMainTree" data-options="fit:true,border:false"></ul>
	</div>
	<div data-options="region:'center'">
		<iframe 
			<s:if test="@com.lxs.oa.message.common.FileStatusEnum@upload.value==status">
				src="${ctx }/person/upload!findPage.action?status=${status }"   
			</s:if>
			<s:if test="@com.lxs.oa.message.common.FileStatusEnum@download.value==status">
				src="${ctx }/person/download!findPage.action?status=${status }"   
			</s:if>
			id="shareFileListIframe" frameborder="0"
			style="border: 0; width: 100%; height: 98%;"></iframe>
	</div>
</body>
</html>