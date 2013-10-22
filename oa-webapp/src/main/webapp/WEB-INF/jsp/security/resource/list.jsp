<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>资源管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>

</head>

<body>
	<div id="navigatorDiv">
	  	<button type="button" id="addButton" class="button positive" actionUrl="${ctx }/security/resource!toAdd.action">
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
	<form id="queryForm" class="form-horizontal" action="${ctx}/security/resource!findPage.action" method="post">
		<fieldset>
		<legend><small>资源查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>访问地址：</label></td>
				<td>
					<s:textfield name="url"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
  
  <form id="deleteForm" action="${ctx }/security/resource!delete.action">
	
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
      	  <th  width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
  		  <th>资源编号</th>
          <th>访问地址</th>
          <th>操作</th>

	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td><input type="checkbox" name="ids" value="${id }"></td>
          <td>${id}</td>
          <td>${url }</td>
          <td><a href="${ctx}/security/resource!toUpdate.action?id=${id}">修改</a></td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
