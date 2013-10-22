<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<%@ include file="/common/global.jsp"%>
    <title>OA协同办公系统</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
    <%@ include file="/common/include-jquery-easyui.jsp" %>
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
	<div id="login_div">
		<TABLE>
		<TR >
			<td ><img src="${ctx}/images/logo_bj_03.png"></td>
			<td width="25%" style="text-align: right; font-size:12px;" valign="bottom">
				<span style="font-weight: bold; color: blue">当前登录用户:${currentUser.realName }</span> &nbsp;&nbsp;&nbsp; <a href="${ctx }/security/user!logout.action"/>注销</a>&nbsp;&nbsp;<br />
			 </td>
		</tr>
		</table>
	</div>
	<div id="left_div" class="easyui-resizable" data-options="minWidth:50" >
		<ul id="treeMenu" class="ztree" ></ul>
	</div>
	<div id="main_div">
		<iframe src="main.jsp"  id="mainFrame" name="mainFrame" scrolling="auto" frameborder="1px" width="100%" height="100%" ></iframe>
	</div>
</body>
</noframes></html>
