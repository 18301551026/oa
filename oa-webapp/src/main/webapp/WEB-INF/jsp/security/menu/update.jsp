<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>用户管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <%@ include file="/common/include-jquery-easyui.jsp" %>
    <%@ include file="/common/include-ztree.jsp" %>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>
	<script type="text/javascript" src="${ctx}/js/editMenu.js"></script>
</head>

<body>
	<div id="editDialog" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',modal:true, closed: true" style="width:500px;height:350px; padding:20px;">
		<div >
	    <form id="editForm" method="post">
	    	<input type="hidden" name="id" id="id" >
	    	<input type="hidden" name="parent.id" id="parentId">
	    	<table style="width: 100%;">
	    		<tr>
	    			<td width="20%">内容:</td>
	    			<td width="80%"><input type="text" name="name" class="txt" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>URL地址:</td>
	    			<td><input type="text" name="url" class="txt" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>URL目标:</td>
	    			<td><input type="text" name="target" class="txt" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>图标地址:</td>
	    			<td><input type="text" name="icon" class="txt" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>自动展开</td>
	    			<td><input type="checkbox" value="true" name="open"> </td>
	    		</tr>
	    	</table>
	    </form>
	    </div>
	    <div style="text-align:center;padding:5px; margin-top: 40px;">
	    	<a class="easyui-linkbutton" id="saveButton">保存</a>
	    	<a class="easyui-linkbutton" id="closeButton">关闭</a>
	    </div>
	</div>
	
	<div id="navigatorDiv" style="padding:5px;">
		<a href="#" class="easyui-linkbutton" id="addRootButton" data-options="iconCls:'icon-add'">添加根菜单</a>
		<a href="#" class="easyui-linkbutton" id="addChildButton" data-options="iconCls:'icon-add'">添加子菜单</a>
		<a href="#" class="easyui-linkbutton" id="editMenuButton" data-options="iconCls:'icon-edit'">修改菜单</a>
		<a href="#" class="easyui-linkbutton" id="deleteMenuButton" data-options="iconCls:'icon-remove'">删除菜单</a>
		<a href="#" class="easyui-linkbutton" id="saveMenuButton" data-options="iconCls:'icon-save'">保存顺序</a>
	</div>
	    
	  <div id="dataDiv" style="padding: 10px; overflow: hidden;">
	    <ul id="menuUpdateTree" class="ztree" style="width: 100%; height: 100%;"></ul>
	  </div>
	  
	</div> 
</body>
</html>
