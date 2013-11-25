<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<title>菜单管理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>


</head>
<body>
	<script type="text/javascript" src="${ctx }/js/menu.js"></script>

	<table id="treeGrid" class="easyui-treegrid">
	</table>
	<div id="treeGridToolBar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="redo();" data-options="iconCls:'icon-edit',plain:true">展开</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="undo();" data-options="iconCls:'icon-save',plain:true">折叠</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="addFun(true)" data-options="iconCls:'icon-add',plain:true">添加根节点</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="orderFun()" data-options="iconCls:'icon-add',plain:true">节点排序</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="treeGrid.treegrid('reload');"
			data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
	<div id="mm" class="easyui-menu" style="width: 120px;">
		<div data-options="iconCls:'icon-add'" onclick="addFun()">添加子节点</div>
		<div data-options="iconCls:'icon-edit'" onclick="editFun()">编辑</div>
		<div data-options="iconCls:'icon-remove'" onclick="deleteFun()">删除</div>
	</div>
</body>

<style>
	.panel-body {
		color: #000000;
		background: none repeat scroll 0 0 #F5F8FA;
	}
	
	.datagrid-body {
		margin: 0;
		overflow: auto;
		padding: 0;
		background: none repeat scroll 0 0 #F5F8FA;
	}
</style>
</html>
