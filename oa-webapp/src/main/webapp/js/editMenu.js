

$(function() {

	

	// 初始化修改菜单的表单
	$('#editForm').form({
		url : ctx + '/security/menu!saveMenu.action',
		onSubmit : function() {
			// 返回false 将阻止提交;
		},
		success : function(data) {
			var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
			var result = eval('(' + data + ')');
			var addSign = result.addSign;
			var node = result.node;
			if (addSign === true) {// 添加
				var parentNode = null;
				if (node.parent) {
					var nodes = zTree.getNodesByParam("id", node.parent.id);
					if (nodes && nodes.length > 0) {
						parentNode = nodes[0];
					}
				}
				zTree.addNodes(parentNode, node);
			} else { // 修改
				var nodes = zTree.getNodesByParam("id", node.id);
				if (nodes && nodes.length > 0) {
					nodes[0].name = node.name;
					nodes[0].url = node.url;
					nodes[0].icon = node.icon;
					nodes[0].target = node.target;
					zTree.updateNode(nodes[0]);
				}
			}

			$("#editDialog").dialog('close');
		}
	});

	// 关闭对话框按钮事件
	$("#closeButton").click(function() {
		$("#editDialog").dialog('close');
	});

	// 保存按钮事件
	$("#saveButton").click(function() {
		$("#editForm").submit();
	});

	// 添加根菜单按钮事件
	$("#addRootButton").click(function() {
		$('#editForm').form('clear');
		$("#editDialog").dialog('open');
	});

	// 添加子菜单按钮事件
	$("#addChildButton").click(function() {
		$('#editForm').form('clear');

		var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
		var nodes = zTree.getSelectedNodes();
		if (nodes && nodes.length > 0) {
			$("#parentId").val(nodes[0].id);
		} else {
			parent.$.messager.alert('选择菜单', '请选择父菜单');
			return;
		}

		$("#editDialog").dialog('open');
	});

	// 修改菜单
	$("#editContentMenuButton, #editMenuButton").click(function() {
		$('#editForm').form('clear');
		var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
		var nodes = zTree.getSelectedNodes();
		if (!nodes || nodes.length <= 0) {
			parent.$.messager.alert('选择菜单', '请选择菜单');
			return;
		}
		$('#editForm').form('load', nodes[0]);
		$("#editDialog").dialog('open');
	});

	$("#deleteMenuButton").click(function() {
		var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
		var nodes = zTree.getSelectedNodes();
		if (!nodes || nodes.length <= 0) {
			parent.$.messager.alert('选择菜单', '请选择菜单');
			return;
		}
		$.messager.confirm('确认信息', '确认要删除吗?', function(r) {
			if (r) {
				$.post(ctx + '/security/menu!deleteMenu.action', {
					id : nodes[0].id
				}, function(data) {
					var n = eval("(" + data + ")");
					var nodes = zTree.getNodesByParam("id", n.id);
					if (nodes && nodes.length > 0) {
						zTree.removeNode(nodes[0]);
					}
				});
			}
		});
	});

	$("#saveMenuButton").click(function() {
		var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
		var nodes = zTree.getNodes();
		recursiveTree2Order(nodes);
		jsonTree = jsonTree.substring(0, jsonTree.length - 1) + "]";

		$.post(ctx + '/security/menu!saveMenuOrder.action', {
			'json2Order' : jsonTree
		}, function(data) {
			alert(data);
		});
	});
});

var jsonTree = "["

function recursiveTree2Order(nodes) {

	var zTree = $.fn.zTree.getZTreeObj("menuUpdateTree");
	for (var i = 0; i < nodes.length; i++) {
		var n = nodes[i];
		var pn = n.getParentNode();
		var pid = null;
		if (pn) {
			pid = pn.id
		}
		jsonTree = jsonTree + "{\"id\": " + n.id + ", \"parent\":{\"id\": "
				+ pid + "}, \"order\": " + zTree.getNodeIndex(n) + "},"

		if (n.children && n.children.length > 0) {
			recursiveTree2Order(n.children);
		}
	}
}