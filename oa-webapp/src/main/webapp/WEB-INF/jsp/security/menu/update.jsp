<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<title>修改节点</title>
</head>
<body>
	<script type="text/javascript">
		$(function() {
			$("#updateMenuForm").form({
				url : ctx + '/security/menu!saveMenu.action',
				onSubmit : function() {
					if ($("#updateMenuForm").form("validate")) {
						return true;
					} else {
						return false;
					}
				},
				success : function(r) {
					if (!r) {
						return;
					}
					var jsonObj = jQuery.parseJSON(r);
					parent.$.modalDialog.openner_treeGrid.treegrid('update', {
						id : jsonObj.id,
						row : {
							name : jsonObj.name,
							url : jsonObj.url,
							order : jsonObj.order
						}
					})
					$.messager.show({
						msg : '修改成功',
						title : '提示'
					});
					parent.$.modalDialog.handler.dialog('close');
					//parent.$.modalDialog.openner_treeGrid.treegrid('reload');之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了
				}
			});
		})
	</script>
	<style>
</style>
	<form id="updateMenuForm" action="" method="post" style="margin: 10px;">
		<s:hidden name="id"></s:hidden>
		<label>名称：</label>
		<s:textfield name="name" type="text"
			cssClass="easyui-validatebox form-control"
			data-options="required:true" placeholder="请输入节点名称"></s:textfield>
		<br /> <label class="control-label">url：</label>
		<s:textfield name="url" type="text" cssClass="form-control"
			placeholder="请输入节点url"></s:textfield>
		<br /> <label class="control-label">排序：</label>
		<s:textfield name="order" type="text"
			cssClass="easyui-validatebox form-control"
			data-options="validType:'number'" placeholder="请输入节点排序"></s:textfield>
		<br /> <label>图标地址：</label>
		<s:textfield type="text" name="icon" cssClass="form-control"
			placeholder="请输入图标地址"></s:textfield>
		<br />
	</form>
<style>
.form-control {
	background-color: #FFFFFF;
	border: 1px solid #CCCCCC;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	color: #555555;
	display: block;
	font-size: 14px;
	height: 30px;
	line-height: 1.42857;
	padding: 0px 3px;
	transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s
		ease-in-out 0s;
	vertical-align: middle;
	width: 250px;
}

label {
	height: 30px;
	line-height: 30px;
	vertical-align: middle;
	float: left;
	text-align: right;
	width: 80px;
}
</style>
</body>

</html>