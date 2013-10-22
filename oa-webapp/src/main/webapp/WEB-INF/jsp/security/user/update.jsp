<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>修改用户</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/edit.js"></script>
</head>

<body>

	<div id="navigatorDiv">
	  	<button type="button" id="saveButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/filesave.png" alt=""/> 保存
  	  	</button>
	  	<button type="button" id="resetButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/reload.png" alt=""/> 重置
  	  	</button>
	  	<button type="button" id="backButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/undo.png" alt=""/> 返回
  	  	</button>
	</div>
	
	<div id="editDiv">
	<form id="editForm" class="form-horizontal" action="${ctx}/security/user!save.action" method="post">
		<s:hidden name="id"></s:hidden>
		<fieldset>
		<legend><small>用户修改</small></legend>
		<table >
			<tr>				
				<td width="20%"><label>用户名称：</label></td>
				<td>
					<s:textfield name="userName"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>密码：</label></td>
				<td>
					<s:textfield name="password"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>真实姓名：</label></td>
				<td>
					<s:textfield name="realName"></s:textfield>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
	</div>


  <div id="dataDiv">    
	<table style="width: 33%; margin-left:1px; float: left;">
	  <thead>
		  <tr>
			<th>角色名称</th>
			<th width="1%">操作</th>
		  </tr>
	  </thead>
	  <tbody>
		  <c:forEach items="${roles}" var="o">
			<tr>
			  <td>${o.roleName }</td>
			  <td>
			  	<input type="button" class="button positive" value="删除" onclick="location.href='${ctx }/security/user!deleteRole.action?id=${id }&roleId=${o.id }'">
			  </td>
			</tr>
		  </c:forEach>
		  <form action="${ctx }/security/user!addRole.action" method="post">
			<s:hidden name="id"></s:hidden>
			<tr>
			  <td>
				<s:select name="roleId" list="#roleList" listKey="id" listValue="roleName"></s:select>
			  </td>
			  <td>
			  	<input type="submit" class="button positive" value="保存">
			  </td>
			</tr>
		  </form>
  	  </tbody>
	 </table>

	  <table style="width: 33%;margin-left:1px; float: left">
	    <thead>
		  <tr>
			<th>部门名称</th>
			<th width="1%">操作</th>
		  </tr>
	    </thead>
		<tbody>
		  <c:forEach items="${depts}" var="o">
			<tr>
			  <td>${o.deptName }</td>
			  <td>
			  	<input type="button" class="button positive" value="删除" onclick="location.href='${ctx }/security/user!deleteDept.action?id=${id }&deptId=${o.id }'">
			  </td>
			</tr>
		  </c:forEach>
		  <form action="${ctx }/security/user!addDept.action" method="post">
			<s:hidden name="id"></s:hidden>
			<tr>
			  <td>
				<s:select name="deptId" list="#deptList" listKey="id" listValue="deptName"></s:select>
			  </td>
			  <td>
			  	<input type="submit" class="button positive" value="保存">
			  </td>
			</tr>
		  </form>
		</tbody>
	  </table>
	  
	  <table style="width: 33%;margin-left:1px; float: left">
		  <thead>
			  <tr>
				<th>职位名称</th>
				<th width="1%">操作</th>
			  </tr>
		  </thead>
        <tbody>
		  <c:forEach items="${jobs}" var="o">
			<tr>
			  <td>${o.jobName }</td>
			  <td>
			  	<input type="button" class="button positive" value="删除" onclick="location.href='${ctx }/security/user!deleteJob.action?id=${id }&jobId=${o.id }'">
			  </td>
			</tr>
		  </c:forEach>
		  <form action="${ctx }/security/user!addJob.action" method="post">
			<s:hidden name="id"></s:hidden>
			<tr>
			  <td>
				<s:select name="jobId" list="#jobList" listKey="id" listValue="jobName"></s:select>
			  </td>
			  <td>
			  	<input type="submit" class="button positive" value="保存">
			  </td>
			</tr>
		  </form>
        </tbody>
	  </table>	  
	</div>          



</body>
</html>
