<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<title>节点排序</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
</head>
<body>
	<script type="text/javascript">
		var setting = {
			view : {
				selectedMulti : false
			},
			edit : {
				enable : true,
				showRemoveBtn : false,
				showRenameBtn : false
			}
		};
		var jsonTree = "["
		$(function() {
			// 初始化菜单
			$.post(ctx + '/security/menu!findMenu.action', function(data) {
				var nodes = eval(data);
				var zTree = $.fn.zTree.init($("#menuUpdateTree"), setting,
						nodes);
				zTree.expandAll(true);
			});
			$("#saveMenuOrder").click(function() {
				var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
				var nodes = zTree.getNodes();
				recursiveTree2Order(nodes);
				jsonTree = jsonTree.substring(0, jsonTree.length - 1) + "]";

				$.post(ctx + '/security/menu!saveMenuOrder.action', {
					'json2Order' : jsonTree
				}, function(data) {
					/* parent.$.messager.alert('排序', '菜单排序成功'); */
					parent.$.modalDialog.openner_treeGrid.treegrid('reload')
					parent.$.modalDialog.handler.dialog('close');

				});
			})
			$("#cancelMenuOrder").click(function() {
				parent.$.modalDialog.handler.dialog('close');
			})
		});
		function recursiveTree2Order(nodes) {
			var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
			for (var i = 0; i < nodes.length; i++) {
				var n = nodes[i];
				var pn = n.getParentNode();
				var pid = null;
				if (pn) {
					pid = pn.id
				}
				jsonTree = jsonTree + "{\"id\": " + n.id
						+ ", \"parent\":{\"id\": " + pid + "}, \"order\": "
						+ zTree.getNodeIndex(n) + "},"

				if (n.children && n.children.length > 0) {
					recursiveTree2Order(n.children);
				}
			}
		}
	</script>
	<ul id="menuUpdateTree" class="ztree"></ul>
	<!-- <a id="cancelMenuOrder" href="javascript:void(0)" style="float: right;"
		class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
	<a id="saveMenuOrder" href="javascript:void(0)" style="float: right;"
		class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a> -->
</body>
</html>
