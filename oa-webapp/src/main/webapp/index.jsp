<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>OA协同办公系统</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>

</head>

<body class="easyui-layout">
	<script type="text/javascript" src="${ctx }/js/index.js"></script>

	<div data-options="region:'north',split:true" style="height:70px;">
		<div class="panel-header panel-title"
			data-option="border:false,fit:true" style="height:63px;border: 0px;padding: 0px;">
			<img alt="logo" src="${ctx }/images/logo.gif" style="margin: 0px;">
			<div style="position: absolute; right: 10px; bottom: 2px;">
				<a href="javascript:void(0)" id="mb" class="easyui-menubutton"
					data-options="menu:'#mm'">${currentUser.realName }</a>
				<div id="mm" style="width: 150px;">
					<div onclick="modifiedPasswordfn()">修改密码</div>
					<div onclick="logout()">注销</div>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'west',title:'菜单管理',split:true"
		style="width: 150px; overflow: hidden;">
		<ul id="treeMenu" class="ztree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="index_tabs">
			<div title="首页" data-options="id:-1,border:false" cache="false">
				<iframe src="${ctx}/portal.jsp" frameborder="0"
					style="border: 0; width: 100%; height: 98%;"></iframe>
			</div>
		</div>
	</div>
</body>
<div id="index_tabsMenu" style="width: 120px; display: none;">
	<div id="closeCurrent" title="close" data-options="iconCls:'delete'">关闭</div>
	<div id="closeOther" title="closeOther" data-options="iconCls:'delete'">关闭其他</div>
	<div id="closeAll" title="closeAll" data-options="iconCls:'delete'">关闭所有</div>
</div>
<div id="modifyPasswordDialog">
	<form id="modifyPasswordForm"
		action="${ctx }/security/user!modifiedPassword.action" method="post"
		style="margin: 10px; font-size: 14px;">
		<table>
			<tr>
				<TD>原始密码： <input type="hidden" name="id" id="userId"><input
					type="hidden" id="pwd" name="pwd">
				</TD>
				<Td><input type="password" placeholder="请输入原始密码" id="oldPwd"
					name="oldPwd" /></Td>
			</tr>
			<tr>
				<TD>新密码：</TD>
				<Td><input type="password" name="password"
					class="field easyui-validatebox" data-options="required:true"
					placeholder="请输入您的新密码" /></Td>
			</tr>
			<tr>
				<TD>确认新密码：</TD>
				<Td><input type="password" name="rePwd"
					class="field easyui-validatebox"
					data-options="required:true,validType:'eqPwd[\'#modifyPasswordForm input[name=password]\']'"
					placeholder="请输入确认密码" /></Td>
			</tr>
		</table>
	</form>
</div>
</html>