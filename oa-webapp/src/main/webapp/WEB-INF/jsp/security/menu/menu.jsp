<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/global.jsp"%>
<title>菜单管理</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<script type="text/javascript">
	var jsonTree = "["
	$(function() {
		treeGrid = $('#treeGrid').treegrid({
			url : ctx + '/security/menu!findMenu.action',
			idField : 'id',
			treeField : 'name',
			/* parentField : 'pid', */
			rownumbers : true,
			fit : true,
			animate : true,
			fitColumns : false,
			border : false,
			nowrap : true,
			columns : [ [ {
				field : 'name',
				title : '菜单名称',
				width : 380
			}, {
				field : 'url',
				title : '菜单url',
				width : 380
			}, {
				field : 'order',
				title : '排序',
				width : 40
			} ] ],
			toolbar : "#treeGridToolBar",
			onContextMenu : onContextMenu
		});
	});
	function deleteFun(id) {
		if (id != undefined) {
			treeGrid.treegrid('select', id);
		}
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$.messager.confirm('询问', '您是否要删除当前节点？', function(b) {
				if (b) {
					$.ajax({
						type : "POST",
						url : ctx + '/security/menu!deleteMenu.action',
						data : "id=" + node.id,
						success : function(msg) {
							if (msg) {
								$.messager.show({
									msg : '删除成功',
									title : '提示'
								});
								treeGrid.treegrid('remove', node.id);
							}
						}
					});
				}
			});
		}
	}

	function editFun(id) {
		if (id != undefined) {
			treeGrid.treegrid('select', id);
		}
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$
					.modalDialog({
						title : '编辑节点',
						width : 400,
						height : 280,
						href : ctx + '/security/menu!toEdit.action?id='
								+ node.id,
						buttons : [
								{
									text : '编辑',
									iconCls : "icon-edit",
									handler : function() {
										parent.$.modalDialog.openner_treeGrid = treeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
										var f = parent.$.modalDialog.handler
												.find('#updateMenuForm');
										f.submit();
									}
								},
								{
									text : '取消',
									iconCls : "icon-cancel",
									handler : function() {
										parent.$.modalDialog.handler
												.dialog('close');
									}
								} ]
					});
		}
	}

	function addFun(flag) {
		var url
		if (flag) {
			url = ctx + '/security/menu!toAdd.action';
		} else {
			var node = treeGrid.treegrid('getSelected');
			url = ctx + '/security/menu!toAdd.action?id=' + node.id
		}
		parent.$.modalDialog({
			title : '添加节点',
			width : 400,
			height : 280,
			href : url,
			buttons : [ {
				text : '添加',
				iconCls : "icon-add",
				handler : function() {
					parent.$.modalDialog.openner_treeGrid = treeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addMenuForm');
					f.submit();
				}
			}, {
				text : '取消',
				iconCls : "icon-cancel",
				handler : function() {
					parent.$.modalDialog.handler.dialog('close');
				}
			} ]
		});
	}
	function orderFun() {
		parent.$
				.modalDialog({
					title : '节点排序',
					width : 300,
					height : 580,
					/* href : ctx + '/security/menu!toOrderMenu.action',*/
					content : '<iframe src='
							+ ctx
							+ "/security/menu!toOrderMenu.action"
							+ ' width="100%" height="99%" id="orderMenuIframe" name="orderMenuIframe" scrolling="yes"  frameborder="0" style="border: 0px;width: 100%; height:99%;"></iframe>',
					onOpen : function() {
						parent.$.modalDialog.openner_treeGrid = treeGrid;//因为排序成功之后，需要刷新这个treeGrid，所以先预定义好
					},
					buttons : [
							{
								text : '保存',
								iconCls : "icon-save",
								handler : function() {
									var zTree = parent.orderMenuIframe.$.fn.zTree
											.getZTreeObj("menuUpdateTree");
									var nodes = zTree.getNodes();
									recursiveTree2Order(nodes);
									jsonTree = jsonTree.substring(0,
											jsonTree.length - 1)
											+ "]";
									$.post(ctx + '/security/menu!saveMenuOrder.action',
													{
														'json2Order' : jsonTree
													},
													function(data) {
														//zTree必须重新加载，否则第二次无法改变顺序
														location.reload();
														//treeGrid.treegrid('reload');
														parent.$.modalDialog.handler.dialog('close');

													});
								}
							},
							{
								text : '取消',
								iconCls:"icon-cancel",
								handler : function() {
									parent.$.modalDialog.handler
											.dialog('close');
								}
							} ]
				});
	}
	function redo() {
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			treeGrid.treegrid('expandAll', node.id);
		} else {
			treeGrid.treegrid('expandAll');
		}
	}

	function undo() {
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			treeGrid.treegrid('collapseAll', node.id);
		} else {
			treeGrid.treegrid('collapseAll');
		}
	}

	function recursiveTree2Order(nodes) {
		var zTree = parent.orderMenuIframe.$.fn.zTree
				.getZTreeObj("menuUpdateTree");
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
</script>
</head>
<body>
	<table id="treeGrid" class="easyui-treegrid">
	</table>
	<div id="treeGridToolBar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="redo();" data-options="iconCls:'icon-edit',plain:true">展开</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="undo();" data-options="iconCls:'icon-save',plain:true">折叠</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="addFun(true)" data-options="iconCls:'icon-add',plain:true">添加根节点</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="orderFun()" data-options="iconCls:'icon-add',plain:true">节点排序</a>
		<div class="datagrid-btn-separator"
			style="float: none; display: inline;"></div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="treeGrid.treegrid('reload');"
			data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
	<div id="mm" class="easyui-menu" style="width: 120px;">
		<div data-options="iconCls:'icon-add'" onclick="addFun()">添加子节点</div>
		<div data-options="iconCls:'icon-edit'" onclick="editFun()">编辑</div>
		<div data-options="iconCls:'icon-remove'" onclick="deleteFun()">删除</div>
	</div>
</body>
<script type="text/javascript">
	function onContextMenu(e, row) {
		/* if (row.children.length != 0) {
			var item = $('#mm').menu('findItem', '删除');
			$('#mm').menu('disableItem', item.target);
		} else {
			var item = $('#mm').menu('findItem', '删除');
			$('#mm').menu('enableItem', item.target);
		} */
		e.preventDefault();
		$(this).treegrid('select', row.id);
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	}
</script>
<style>
.panel-body {
	color: #000000;
	background: none repeat scroll 0 0 #F5F8FA;
}

.datagrid-body {
	margin: 0;
	overflow: auto;
	padding: 0;
	background: none repeat scroll 0 0 #F5F8FA;
}
</style>
</html>
