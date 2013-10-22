<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

  <%@ include file="/common/global.jsp"%>
  <title>OA会员登陆</title>
  <%@ include file="/common/meta.jsp" %>
  
  <link rel="stylesheet" href="css/login_lan_css.css" type="text/css"></link>
  <script type="text/javascript">
  	function doSubmit() {
  		document.forms[0].submit();
  	}
  </script>
</head>

<body >
<form name="loginForm" id="loginForm" method="post" action="${ctx}/security/user!login.action">
<div id="wrap">
	<div class="top">


		<div class="logo">
				<img src="images/logo_bj_03.png" width="336" height="57" />
		</div>
	</div>
	<div class="propaganda_xian"></div>
	<div class="content">
		<div class="link_right"><a><span class="!bold_zi">设为首页</span></a> | <a>加入收藏</a> | <a href="#">使用帮助</a> | <a href="JavaScript:aboutE();">关于e管理</a></div>
		<div class="table_nr">
			<input type="hidden" name="remember_me" value="on" />
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td width="30%" align="right">用户名 ：</td>
					<td align="left"><input type="text" name="userName" class="input"/></td>
				</tr>
				<tr>
					<td width="40%" align="right">密 码 ：</td>
					<td align="left"><input type="password" name="password" class="input"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="left" style="padding-top: 5px;">
						<input type="submit" value="登陆">					
					</td>
				</tr>

			</table>
		</div>
	</div>

	<div class="bottom">
		<div class="bottom_zi">系统要求：IE6.0以上&nbsp;&nbsp;分辨率：建议在1024*768或以上分辨率使用│服务热线:<br />客服QQ：&nbsp;&nbsp;&nbsp;&nbsp;│Copyright (C) </div>
	</div>
</div>
</form>
</body>
</html>
