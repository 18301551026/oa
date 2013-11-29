<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>用户修改</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-styles.jsp"%>
</head>

<body class="editBody">
	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<div class="btn-group pull-right btn-group-sm">
		<button type="button" class="btn btn-info" id="saveButton">
			<span class="glyphicon glyphicon-ok"></span> 保存
		</button>
		<button type="button" class="btn btn-info"
			actionUrl="${ctx }/security/user!toUpdate.action?id=${id}"
			id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/security/user!save.action" method="post"
		id="editForm">
		<s:hidden name="id"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="userName">登录名：</label></Td>
				<Td class="query_input"><s:textfield name="userName"
						placeholder="请输入登陆名" cssClass="form-control validate[required]"
						id="userName"></s:textfield></Td>
				<Td class="control-label"><label for="pwd">密码：</label></Td>
				<Td class="query_input"><s:textfield name="password"
						placeholder="请输入密码" cssClass="form-control validate[required]"
						id="pwd"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="realName">真实姓名：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="realName" placeholder="请输入真实姓名"
						cssClass="form-control validate[required]" id="realName"></s:textfield></Td>
			</tr>
		</table>
	</form>
	<table style="width: 33%; margin-left: 1px; float: left;"
		class="table table-bordered table-striped table-hover">
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
					<td><input type="button" class="btn btn-info btn-xs "
						value="删除"
						onclick="location.href='${ctx }/security/user!deleteRole.action?id=${id }&roleId=${o.id }'">
					</td>
				</tr>
			</c:forEach>
			<s:if test="#roleList.size>0">
				<form action="${ctx }/security/user!addRole.action" method="post">
					<s:hidden name="id"></s:hidden>
					<tr>
						<td><s:select name="roleId" list="#roleList" listKey="id"
								listValue="roleName" cssClass="form-control-mini"></s:select></td>
						<td><input type="submit" class="btn btn-info btn-xs "
							value="保存"></td>
					</tr>
				</form>
			</s:if>
		</tbody>
	</table>

	<table style="width: 33%; margin-left: 1px; float: left"
		class="table table-bordered table-striped table-hover">
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
					<td><input type="button" class="btn btn-info btn-xs "
						value="删除"
						onclick="location.href='${ctx }/security/user!deleteDept.action?id=${id }&deptId=${o.id }'">
					</td>
				</tr>
			</c:forEach>
			<s:if test="#deptList.size>0">
				<form action="${ctx }/security/user!addDept.action" method="post">
					<s:hidden name="id"></s:hidden>
					<tr>
						<td><s:select name="deptId" list="#deptList" listKey="id"
								listValue="deptName" cssClass="form-control-mini"></s:select></td>
						<td><input type="submit" class="btn btn-info btn-xs "
							value="保存"></td>
					</tr>
				</form>
			</s:if>
		</tbody>
	</table>

	<table style="width: 33%; margin-left: 1px; float: left"
		class="table table-bordered table-striped table-hover">
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
					<td><input type="button" class="btn btn-info btn-xs "
						value="删除"
						onclick="location.href='${ctx }/security/user!deleteJob.action?id=${id }&jobId=${o.id }'">
					</td>
				</tr>
			</c:forEach>
			<s:if test="#jobList.size>0">
				<form action="${ctx }/security/user!addJob.action" method="post">
					<s:hidden name="id"></s:hidden>
					<tr>
						<td><s:select name="jobId" cssClass="form-control-mini"
								list="#jobList" listKey="id" listValue="jobName"></s:select></td>
						<td><input type="submit" class="btn btn-info btn-xs"
							value="保存"></td>
					</tr>
				</form>
			</s:if>
		</tbody>
	</table>
</body>
</html>
