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
	  	<button type="button" id="addButton" class="button positive" actionUrl="${ctx }/work/expense!toAdd.action">
    		<img src="${ctx}/js/easyui/themes/icons/edit_add.png" alt=""/> 新建
  	  	</button>
	  	<button type="button" id="startButton" class="button positive" actionUrl="${ctx }/work/expense!start.action">
    		<img src="${ctx}/js/easyui/themes/icons/tip.png" alt=""/> 启动
  	  	</button>
	  	<button type="button" id="deleteButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/edit_remove.png" alt=""/> 删除
  	  	</button>
	  	<button type="button" id="queryButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/search.png" alt=""/> 查询
  	  	</button>
	</div>
	
	<div id="queryDiv">
	<form id="queryForm" class="form-horizontal" action="${ctx}/work/expense!findPage.action" method="post">
		<s:hidden name="status" ></s:hidden>
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
  
  <form id="deleteForm" action="${ctx }/work/expense!delete.action" method="post">
    <s:hidden name="definitionKey" value="%{@ com.lxs.process.common.ProcessEnum@expense}"></s:hidden>
	
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
			<th><input type="checkbox" id="checkAllCheckBox"></th>
			<th>报销金额</th>
			<th>状态</th>
			<th>标题</th>
			<th>操作</th>
	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td><input type="checkbox" name="ids" value="${id }"></td>
          <td>${money}</td>
          <td>${status }</td>
          <td>${title }</td>
          <td><a href="${ctx}/work/expense!toUpdate.action?id=${id}">修改</a></td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>