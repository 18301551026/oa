<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>代办任务管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>

</head>

<body>
	<div id="navigatorDiv">
	  	<button type="button" id="deleteButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/edit_remove.png" alt=""/> 删除
  	  	</button>
	  	<button type="button" id="queryButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/search.png" alt=""/> 查询
  	  	</button>
	</div>
	
	<div id="queryDiv">
	<form id="queryForm" class="form-horizontal" action="${ctx}/process/task!findPage.action" method="post">
		<fieldset>
		<legend><small>代办任务查询</small></legend>
		<table >
			<tr>
				<td width="10%"><label>任务名称：</label></td>
				<td width="40%">
					<s:textfield name="taskName"></s:textfield>
				</td>
				<td width="10%"><label>流程列表：</label></td>
				<td>
					<s:select name="definitionKey" list="@ com.lxs.process.common.ProcessEnum@values()" listValue="value" headerKey="" headerValue="全部" ></s:select>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
  
  <form id="deleteForm" action="${ctx }/process/task!delete.action">
	
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
      	  <th  width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
          <th>任务名称</th>
          <th>开始时间</th>
          <th>申请人</th>
          <th>标题</th>
          <th>流程名称</th>
          <th>操作</th>
	    </tr>
	  <tbody>
	  	<s:iterator value="#page.result">
  	    <tr>
			<td><input type="checkbox" name="ids" value="${task.id }"></td>
			<td>${task.name }</td>
			<td><s:property value="task.createTime"/></td>
			<td>${requestUser.userName }</td>
			<td>${model.title }</td>
			<td>${processName }</td>
			<td><a href="${ctx }/process/task!toTask.action?taskId=${task.id}">执行任务</a></td>
	    </tr>
	    </s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
