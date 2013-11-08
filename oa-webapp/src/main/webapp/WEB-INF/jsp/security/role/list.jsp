<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>角色</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript">
	function assignMenu(id) {
		parent.$.modalDialog({
			title : "分配菜单",
			width : 260,
			height : 500,
			href : ctx + '/security/role!toAssignMenu.action?id=' + id,
			buttons : [
					{
						text : '保存',
						iconCls : 'icon-save',
						handler : function() {
							var f = parent.$.modalDialog.handler
									.find('#assignMenuForm');
							f.submit();

						}
					}, {
						text : '关闭',
						iconCls : 'icon-cancel',
						handler : function() {
							parent.$.modalDialog.handler.dialog('close');
						}
					} ]
		});
	}
</script>
<body>
	<%-- <div id="navigatorDiv">
	  	<button type="button" id="addButton" class="button positive" actionUrl="${ctx }/security/role!toAdd.action">
    		<img src="${ctx}/js/easyui/themes/icons/edit_add.png" alt=""/> 新建
  	  	</button>
	  	<button type="button" id="deleteButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/edit_remove.png" alt=""/> 删除
  	  	</button>
	  	<button type="button" id="queryButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/search.png" alt=""/> 查询
  	  	</button>
	</div>
	
	<div id="queryDiv">
	<form id="queryForm" class="form-horizontal" action="${ctx}/security/role!findPage.action" method="post">
		<fieldset>
		<legend><small>角色查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>角色名称：</label></td>
				<td>
					<s:textfield name="roleName"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
  
  <form id="deleteForm" action="${ctx }/security/role!delete.action">
	
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
      	  <th  width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
  		  <th>角色编号</th>
          <th>角色名称</th>
          <th>操作</th>

	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td><input type="checkbox" name="ids" value="${id }"></td>
          <td>${id}</td>
          <td>${roleName }</td>
          <td>
            <a href="${ctx}/security/role!toUpdate.action?id=${id}">修改</a>
          	<a href="javascript:assignMenu(${id });" id="assignMenuButton">分配菜单</a>    
          </td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form> --%>
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button id="addButton"
					actionUrl="${ctx }/security/user!toAdd.action"
					class="btn btn-default ">
					<span class="glyphicon glyphicon-plus"></span> 新建
				</button>
				<button id="deleteButton" class="btn btn-default">
					<span class="glyphicon glyphicon-minus"></span> 删除
				</button>
				<button id="queryButton" class="btn btn-default">
					<span class="glyphicon glyphicon-search"></span> 查询
				</button>
			</div>
			<div class="pull-right" style="margin-top: 6px;">
				<a href="javascript:void(0)" title="查询表单"
					id="showOrHideQueryPanelBtn"><span
					class="glyphicon glyphicon-chevron-down pull-right"></span> 查询条件</a>
			</div>
		</div>
		<div class="panel-body hide" id="queryPanel">
			<form role="form" id="queryForm" class="form-horizontal"
				action="${ctx}/security/role!findPage.action" method="post">
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="roleName">角色名称：</label></Td>
						<Td class="query_input"><s:textfield name="roleName"
								cssClass="form-control" id="roleName"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form method="post" action="${ctx}/security/role!findPage.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>角色编号</th>
					<th>角色名称</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${id}</td>
						<td>${roleName }</td>
						<td><a href="${ctx}/security/role!toUpdate.action?id=${id}">修改</a>
							<a href="javascript:assignMenu(${id });">分配菜单</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>

	<div id="assignMenuDialog" class="easyui-dialog" title="分配菜单"
		data-options="iconCls:'icon-save',modal:true, closed: true">
		<input id="roleId" type="hidden" name="roleId">
		<div id="data">
			<ul id="assignMenuTree" class="ztree"></ul>
		</div>
		<!-- <div style="text-align: center; padding-top: 50px;">
			<a class="easyui-linkbutton" id="saveButton">保存</a> <a
				class="easyui-linkbutton" id="closeButton">关闭</a>
		</div> -->
	</div>
</body>
</html>
