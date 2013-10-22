<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>报销单管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/grid.js"></script>

</head>

<body>
	<div id="navigatorDiv">
	  	<button type="button" id="queryButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/search.png" alt=""/> 查询
  	  	</button>
	</div>
	
	<div id="queryDiv">
	<form id="queryForm" class="form-horizontal" action="${ctx}/work/expenseFinished!findPage.action" method="post">
		<fieldset>
		<legend><small>报销单查询</small></legend>
		<table >
			<tr>
				<td width="20%"><label>最小金额：</label></td>
				<td>
					<s:textfield name="startMoney"></s:textfield>
				</td>
				<td width="20%"><label>最大金额：</label></td>
				<td>
					<s:textfield name="endMoney"></s:textfield>
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
			<th>报销金额</th>
			<th>状态</th>
			<th>标题</th>
			<th>操作</th>
	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td>${money}</td>
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
          	<a href="${ctx }/work/expenseFinished!watch.action?id=${id}&definitionKey=<s:property value='@ com.lxs.process.common.ProcessEnum@expense'/>">查看</a>
		  </td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>

  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
