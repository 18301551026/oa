<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>修改角色</title>
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
		<button type="button" class="btn btn-info" id="resetButton"
			actionUrl="${ctx}/security/role!toUpdate.action?id=${id}">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/security/role!save.action" method="post"
		id="editForm">
		<s:hidden name="id"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="roleName">角色名称：</label></Td>
				<Td class="query_input" colspan="2"><s:textfield
						name="roleName" placeholder="请输入角色名称"
						cssClass="form-control validate[required]" id="roleName"></s:textfield></Td>
			</tr>

		</table>
	</form>
	<div style="width: 50%; float: left;">
		<table class="table table-bordered table-striped table-hover">
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
						<td><input type="button" class="btn btn-info btn-xs"
							value="删除"
							onclick="location.href='${ctx }/security/role!deleteResource.action?id=${id }&resourceId=${o.id }'">
						</td>
					</tr>
				</c:forEach>
				<s:if test="#resourceList.size>0">
					<form action="${ctx }/security/role!addResource.action"
						method="post">
						<s:hidden name="id"></s:hidden>
						<tr>
							<td colspan="2"><s:select name="resourceId"
									cssClass="form-control" list="#resourceList" listKey="id"
									listValue="url"></s:select></td>
							<td><input type="submit" class="btn btn-info btn-xs" value="保存">
							</td>
						</tr>
					</form>
				</s:if>
			</tbody>
		</table>
	</div>
	<div style="width: 48%; float: left;">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>用户编号
					</td>
					<th>登录名
					</td>
					<th>真实姓名
					</td>
					<th width="8%">操作
					</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="o">
					<tr>
						<td>${o.id}</td>
						<td>${o.userName }</td>
						<td>${o.realName }</td>
						<td><input type="button" class="btn btn-info btn-xs" value="删除"
							onclick="location.href='${ctx }/security/role!deleteUser.action?id=${id }&userId=${o.id }'">
						</td>
					</tr>
				</c:forEach>
				<s:if test="#userList.size>0">
					<form action="${ctx }/security/role!addUser.action" method="post">
						<s:hidden name="id"></s:hidden>
						<tr>
							<td colspan="3"><s:select name="userId" list="#userList"
									cssClass="form-control" listKey="id" listValue="realName"></s:select></td>
							<td><input type="submit" class="btn btn-info btn-xs" value="保存">
							</td>
						</tr>
					</form>
				</s:if>
			</tbody>
		</table>
	</div>
</body>
</html>
