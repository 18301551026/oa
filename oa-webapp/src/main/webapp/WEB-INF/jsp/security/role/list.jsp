<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>用户管理</title>
	<%@ include file="/common/meta.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <%@ include file="/common/include-ztree.jsp" %>
    <%@ include file="/common/include-jquery-easyui.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>
	<script type="text/javascript" src="${ctx}/js/assignMenu.js"></script>
	
</head>

<body>
	<div id="navigatorDiv">
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
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
  
  	<div id="assignMenuDialog" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',modal:true, closed: true" style="width:600px;height:500px; padding:10px;">
		<input id="roleId" type="hidden" name="roleId">
	    <div id="data" style="width:90%; height:80%; ">
	      <ul id="assignMenuTree" class="ztree" style="width: 100%; height: 100%; "></ul>
	    </div>	
	    <div style="text-align:center; padding-top: 50px;">
	    	<a class="easyui-linkbutton" id="saveButton">保存</a>
	    	<a class="easyui-linkbutton" id="closeButton">关闭</a>
	    </div>
	</div>  
</body>
</html>
