<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>历史流程管理</title>
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
	<form id="queryForm" class="form-horizontal" action="${ctx}/security/dept!findPage.action" method="post">
		<fieldset>
		<legend><small>历史流程查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>流程列表：</label></td>
				<td >
					<s:select name="definitionKey" list="@ com.lxs.process.common.ProcessEnum@values()" listValue="value" headerKey="" headerValue="全部"></s:select>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>
  
  <form id="deleteForm" action="${ctx }/process/history!delete.action">
	
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
      	  <th  width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
		  <th>Id</th>
          <th>businessKey</th>
          <th>processDefinitionId</th>
          <th>StartTime</th>
          <th>EndTime</th>
          <th>DurationInMillis</th>
          <th>EndActivityId</th>
          <th>StartActivityId</th>
      </tr>
	  <tbody>
		<s:iterator value="#page.result">
  	    <tr>
			<td><input type="checkbox" name="ids" value="${id }"></td>
			<td>${id }</td>
			<td>${businessKey }</td>
			<td>${processDefinitionId }</td>
			<td>
				<s:date name="startTime" var="formatStartTime" format="yyyy-MM-dd HH:mm:ss"/>
				<s:property value="formatStartTime"/>
			</td>
			<td>
				<s:date name="endTime" var="formatEndTime" format="yyyy-MM-dd HH:mm:ss"/>
				<s:property value="formatEndTime"/>
			</td>
			<td>${durationInMillis }</td>
			<td>${endActivityId }</td>
			<td>${startActivityId }</td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
