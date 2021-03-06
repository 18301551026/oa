<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>修改资源</title>
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
			actionUrl="${ctx}/security/resource!toUpdate.action?id=${id}">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/security/resource!save.action" method="post"
		id="editForm">
		<s:hidden name="id"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="url">访问地址：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="url"
						placeholder="请输入访问地址" cssClass="form-control validate[required]"
						id="url"></s:textfield></Td>
			</tr>

		</table>
	</form>
	<table class="table table-bordered table-striped table-hover">
		<thead>
			<tr>
				<th>角色编号</th>
				<th>角色名称</th>
				<th width="1%">操作</th>
			</tr>
		<tbody>
			<c:forEach items="${roles}" var="o">
				<tr>
					<td>${o.id}</td>
					<td>${o.roleName }</td>
					<td><input type="button" class="btn btn-info  btn-xs"
						value="删除"
						onclick="location.href='${ctx }/security/resource!deleteRole.action?id=${id }&roleId=${o.id }'">

					</td>
				</tr>
			</c:forEach>

			<s:if test="#roleList.size>0">
				<form action="${ctx }/security/resource!addRole.action"
					method="post">
					<s:hidden name="id"></s:hidden>
					<tr>
						<td colspan="2"><s:select name="roleId" list="#roleList"
								cssClass="form-control" listKey="id" listValue="roleName"></s:select></td>
						<td><input type="submit" class="btn btn-info btn-xs"
							value="保存"></td>
					</tr>
				</form>
			</s:if>

		</tbody>
	</table>
</body>
</html>
