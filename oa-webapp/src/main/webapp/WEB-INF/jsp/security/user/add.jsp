<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>用户添加</title>
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
		<button type="button" class="btn btn-info" id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/security/user!save.action" method="post"
		id="editForm">
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
</body>
</html>
