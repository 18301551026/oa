<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>分配菜单</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<script type="text/javascript">
		var assignMenuTreeSetting = {
			check : {
				enable : true
			}
		};
		$(function() {
			// 初始化菜单
			$.post(ctx + '/security/menu!findCheckedMenuByRole.action', {
				roleId : "${id}"
			}, function(data) {
				var assignMenuTreeNodes = eval(data);
				/*  $.fn.assignMenuTree.destroy(); */
				var assignMenuTree = $.fn.zTree.init($("#assignMenuTree"),
						assignMenuTreeSetting, assignMenuTreeNodes);
				assignMenuTree.expandAll(true);
			});

			$("#assignMenuForm").form({
				onSubmit : function() {
					var zTree = $.fn.zTree.getZTreeObj("assignMenuTree");
					var nodes = zTree.getCheckedNodes(true);
					var roleId = $("#roleId").val();
					var param = "id=" + roleId;
					for ( var i in nodes) {
						param = param + "&ids=" + nodes[i].id
					}
					$.ajax({
						type : "POST",
						url : ctx + "/security/role!assignMenu.action",
						data : param,
						success : function(data) {
							parent.$.messager.alert('分配菜单', '分配菜单成功');
							parent.$.modalDialog.handler.dialog('close');
						}
					});
					return false;
				}
			});

		})
	</script>
	<form id="assignMenuForm" method="post" action="">
		<s:hidden name="roleId" id="roleId" value="%{id}"></s:hidden>
		<ul id="assignMenuTree" class="ztree"></ul>
	</form>
</body>
</html>