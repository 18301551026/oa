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
	  	<button type="button" id="addButton" class="button positive" actionUrl="${ctx }/work/leave!toAdd.action">
    		<img src="${ctx}/js/easyui/themes/icons/edit_add.png" alt=""/> 新建
  	  	</button>
	  	<button type="button" id="startButton" class="button positive" actionUrl="${ctx }/work/leave!start.action">
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
	<form id="queryForm" class="form-horizontal" action="${ctx}/work/leave!findPage.action" method="post">
		<s:hidden name="status" ></s:hidden>
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
  
  <form id="deleteForm" action="${ctx }/work/leave!delete.action" method="post">
	<s:hidden name="definitionKey" value="%{@ com.lxs.process.common.ProcessEnum@leave}"></s:hidden>
	<div id="dataDiv">    
    <table width="100%" >
	  <thead>
	    <tr>
			<th width="1%"><input type="checkbox" id="checkAllCheckBox"></th>
			<th>请假天数</th>
			<th>开始时间</th>
			<th>状态</th>
			<th>标题</th>
			<th>操作</th>

	    </tr>
	  <tbody>
  		<s:iterator value="#page.result">
  	    <tr>
          <td><input type="checkbox" name="ids" value="${id }"></td>
          <td>${days}</td>
          <td>${startDate }</td>
          <td>${status }</td>
          <td>${title }</td>
          <td><a href="${ctx}/work/leave!toUpdate.action?id=${id}">修改</a></td>
	    </tr>
		</s:iterator>
	  </tbody>
	</table>
    </div>
      	
  </form>
  
  <tags:pagination page="${page }"></tags:pagination>  
</body>
</html>
