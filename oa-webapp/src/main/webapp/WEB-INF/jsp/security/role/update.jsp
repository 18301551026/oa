<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>修改角色</title>
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
	<form id="editForm" class="form-horizontal" action="${ctx}/security/role!save.action" method="post">
		<s:hidden name="id"></s:hidden>
		<fieldset>
		<legend><small>角色修改</small></legend>
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

	<div id="dataDiv">    
	<div style="width: 50%; float: left;">
	<table>
	  <thead>
	      <tr>
            <th>资源编号</th>
            <th>访问地址</th>
            <th width="8%">操作</th>
	      </tr>
      </thead>
	  <tbody>
		  <c:forEach items="${resources}" var="o">
			<tr>
			  <td>${o.id}</td>
			  <td>${o.url }</td>
			  <td>
				<input type="button" class="button positive" value="删除" onclick="location.href='${ctx }/security/role!deleteResource.action?id=${id }&resourceId=${o.id }'">			  
			  </td>
			</tr>
		  </c:forEach>
		  <form action="${ctx }/security/role!addResource.action" method="post">
			<s:hidden name="id"></s:hidden>
			<tr>
			  <td colspan="2">
				<s:select name="resourceId" list="#resourceList" listKey="id" listValue="url"></s:select>
			  </td>
			  <td>
				<input type="submit" class="button positive" value="保存" >			  
			  </td>
			</tr>
		  </form>
	  </tbody>
	  </table>
	  </div>
	  <div style="width: 48%; float: left;">
		<table>
			<thead>
			  <tr>
				<th>用户编号</td>
				<th>登录名</td>
				<th>真实姓名</td>
				<th width="8%">操作</td>
			  </tr>
			</thead>
			<tbody>
			  <c:forEach items="${users}" var="o">
				<tr>
				  <td>${o.id}</td>
				  <td>${o.userName }</td>
				  <td>${o.realName }</td>
				  <td>
					<input type="button" class="button positive" value="删除" onclick="location.href='${ctx }/security/role!deleteUser.action?id=${id }&userId=${o.id }'">				  
				  </td>
				</tr>
			  </c:forEach>
			  <form action="${ctx }/security/role!addUser.action" method="post">
				<s:hidden name="id"></s:hidden>
				<tr>
				  <td colspan="2">
					<s:select name="userId" list="#userList" listKey="id" listValue="realName" ></s:select>
				  </td>
				  <td>
					<input type="submit" class="button positive" value="保存" >			  
				  </td>
				</tr>
			  </form>
			</tbody>
		  </table>
		</div>	  		  	
    </div>

</body>
</html>
