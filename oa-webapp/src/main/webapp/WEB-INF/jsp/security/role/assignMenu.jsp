<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>分配菜单</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>


</head>
<body>
	<script type="text/javascript" src="${ctx }/js/role-assignMenu.js"></script>

	<form id="assignMenuForm" method="post" action="">
		<s:hidden name="roleId" id="roleId" value="%{id}"></s:hidden>
		<ul id="assignMenuTree" class="ztree"></ul>
	</form>
</body>
</html>