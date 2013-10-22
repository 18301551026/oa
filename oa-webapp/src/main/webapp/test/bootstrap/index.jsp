<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/common/global.jsp"%>
    <title>OA协同办公系统</title>
	<%@ include file="/common/meta.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
	<%@ include file="/common/include-bootstap.jsp" %>
    <%@ include file="/common/include-ztree.jsp" %>

	
	<script type="text/javascript">
		var setting = {	};
		$(document).ready(function(){
			$.post('${ctx}/security/menu!findMenuByUser.action', function(data){
				var nodes = eval(data);
				$.fn.zTree.init($("#treeMenu"), setting, nodes);
			});		
			
		});
	</script>    
</head>
<body>

<!-- 导航 -->
<header class="navbar navbar-inverse navbar-fixed-top" role="banner">
  <div class="container">
	<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
  
    <div class="navbar-header">
      <a href="#" class="navbar-brand">
      	<span class="glyphicon glyphicon-star"></span>
      	办公系统
      </a>      
    </div>
    <nav class="collapse navbar-collapse navbar-right bs-navbar-collapse" role="navigation">
      <ul class="nav navbar-nav">
        <li>
          <a href="../components">新邮件<span class="badge pull-right">42</span></a>
        </li>
        <li>
          <a href="../javascript">通知</a>
        </li>
        <li>
          <a href="../customize">新闻</a>
        </li>
		<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">登陆用户<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="#">修改密码</a></li>
              <li><a href="#">注销</a></li>
              <li class="divider"></li>
              <li><a href="#">退出系统</a></li>
			</ul>
		</li>        
      </ul>
    </nav>
  </div>
</header>

<div class="container">
  <div class="row">
    <div class="col-md-2">
		<ul id="treeMenu" class="ztree" ></ul>
    </div>
    <div role="main" class="col-md-10">
    	<iframe id="mainFrame" name="mainFrame" scrolling="no" frameborder="0" width="100%" height="100%" ></iframe>
    </div>
  </div>    
</div>

</body>
</html>
