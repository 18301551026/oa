<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<title>节点排序</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>


</head>
<body>
	<script type="text/javascript" src="${ctx }/js/menu-order.js"></script>

	<ul id="menuUpdateTree" class="ztree"></ul>
	<!-- <a id="cancelMenuOrder" href="javascript:void(0)" style="float: right;"
		class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
	<a id="saveMenuOrder" href="javascript:void(0)" style="float: right;"
		class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a> -->
</body>
</html>
