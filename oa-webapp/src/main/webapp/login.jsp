<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="login_page">
<head>
<%@ include file="/common/global.jsp"%>
<title>登陆</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#login_form").validationEngine();
	});
</script>
<body>
	<div class="login_box">
		<form action="${ctx}/security/user!login.action" method="post"
			id="login_form">
			<div class="top_b">用户登陆</div>
			<div class="cnt_b">
				<div class="input-group">
					<span class="input-group-addon"><i
						class="glyphicon glyphicon-user"></i></span> <input type="text"
						id="username" autofocus="true" name="userName"
						placeholder="请输入用户名" class="form-control validate[required]" />
				</div>
				<div class="input-group">
					<span class="input-group-addon"><i
						class="glyphicon glyphicon-lock"></i></span> <input type="password"
						id="password" name="password" placeholder="请输入用户密码"
						class="form-control validate[required]" />
				</div>

			</div>
			<div class="btm_b clearfix">
				<button class="btn btn-default pull-right" type="submit">登陆</button>
			</div>
		</form>
	</div>
</body>
</html>