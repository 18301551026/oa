<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<title>添加子节点</title>
</head>
<body>
	<script type="text/javascript">
		$(function() {
			$("#addMenuForm").form({
				url : ctx + '/security/menu!saveMenu.action',
				onSubmit : function() {
					if ($("#addMenuForm").form("validate")) {
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
					parent.$.modalDialog.openner_treeGrid.treegrid('append', {
						parent : jsonObj.pid,
						data : [ {
							id : jsonObj.id,
							name : jsonObj.name,
							url : jsonObj.url,
							order : jsonObj.order
						} ]

					});
					$.messager.show({
						msg : '添加成功',
						title : '提示'
					});
					parent.$.modalDialog.handler.dialog('close');
					//parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了

				}
			});
		});
	</script>
	<form id="addMenuForm" method="post" style="margin: 10px;" role="form">
		<s:hidden name="pid" value="%{id}"></s:hidden>
		<label>名称：</label><input name="name" type="text"
			class="easyui-validatebox form-control" data-options="required:true"
			placeholder="请输入名称" /><br /> <label class="control-label">url：</label><input
			name="url" type="text" placeholder="请输入节点url" class="form-control" /><br />
		<label>排序：</label><input name="order" type="text" value="0"
			class="easyui-validatebox form-control"
			data-options="validType:'number'" title="请输入输入节点排序" /><br />
		</div>
		<label>图标地址：</label><input type="text" name="icon"
			class="form-control"></input><br />
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