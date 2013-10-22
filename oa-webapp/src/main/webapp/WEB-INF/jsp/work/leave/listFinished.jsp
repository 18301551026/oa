<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>请假单管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>

</head>

<body>
	<div id="navigatorDiv">
	  	<button type="button" id="queryButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/search.png" alt=""/> 查询
  	  	</button>
	</div>
	
	<div id="queryDiv">
	<form id="queryForm" class="form-horizontal" action="${ctx}/work/leave!leaveFinished!findPage.action" method="post">
		<fieldset>
		<legend><small>请假单查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>开始日期：</label></td>
				<td>
					<s:textfield name="startDate" onclick="WdatePicker()"></s:textfield>
				</td>
				<td width="20%"><label>结束日期：</label></td>
				<td>
					<s:textfield name="endDate" onclick="WdatePicker()"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>

	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
			<th>请假天数</th>
			<th>开始时间</th>
			<th>状态</th>
			<th>标题</th>
			<th>操作</th>

	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td>${days}</td>
          <td>${startDate }</td>
          <td>
          	<s:if test="@com.lxs.process.common.StatusEnum@success.value == status">
          		<span style="color: green;">审批成功</span>
          	</s:if>
          	<s:else>
          		<span style="color: red;">审批失败</span>
          	</s:else>
          </td>
          <td>${title }</td>
          <td>
          	<a href="${ctx }/work/leaveFinished!watch.action?id=${id}&definitionKey=<s:property value='@ com.lxs.process.common.ProcessEnum@leave'/>">查看</a>
		  </td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>

  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
