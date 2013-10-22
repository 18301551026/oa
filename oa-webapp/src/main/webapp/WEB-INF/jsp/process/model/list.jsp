<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>模型管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>

</head>

<body>
	<div id="navigatorDiv">
	  	<button type="button" id="createModelButton" class="button positive" onclick="window.open('${ctx }/process/model!toAdd.action');">
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
	<form id="queryForm" class="form-horizontal" action="${ctx}/process/model!findPage.action" method="post">
		<fieldset>
		<legend><small>模型查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>模型名称：</label></td>
				<td>
					<s:textfield></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
  
  <form id="deleteForm" action="${ctx }/process/model!delete.action">
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
      	  <th  width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
          <th>Id</th>
          <th>Name</th>
          <th>Key</th>
          <th>Version</th>
          <th>创建时间</th>
          <th>最后更新时间</th>
          <th>元数据</th>
          <th width="10%">操作</th>

	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
			<td><input type="checkbox" name="ids" value="${id }"></td>
			<td>${id }</td>
			<td>${key }</td>
			<td>${name}</td>
			<td>${version}</td>
			<td>${createTime}</td>
			<td>${lastUpdateTime}</td>
			<td>${metaInfo}</td>
			<td>
				<a href="${ctx }/service/editor?id=${id}" target="_bank">修改</a>
				<a href="${ctx }/process/model!deploy.action?modelId=${id}">部署</a>			
				<a href="${ctx }/process/model!export.action?modelId=${id}">导出</a>			
			</td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
