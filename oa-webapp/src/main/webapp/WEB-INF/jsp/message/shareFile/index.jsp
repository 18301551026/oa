<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>共享文件</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<style type="text/css">
.layout-panel-west .panel-header {
	border-top: 0px;
	border-left: 0px;
}

.layout-panel-west .panel-body {
	border-left: 0px;
}
</style>
<script type="text/javascript">
	var shareFileTree;
	$(function() {
		shareFileTree = $("#shareMainTree")
				.tree(
						{
							url : ctx + "/person/shareFileTree!getTree.action",
							id : 'id',
							lines : true,
							animate : true,
							onDblClick : function(node) {
								if (node.state == 'closed') {
									$(this).tree('expand', node.target);
								} else {
									$(this).tree('collapse', node.target);
								}
							},
							onClick : function(node) {
								/* shareFileLoad(basePath
										+ '/share/file!findPageTOJson.action?tree.id='
										+ node.id + "&randomnum="
										+ Math.floor(Math.random() * 1000000),
										node.text); */
								var status = $("#status").val();
								var url;
								if (status == 1) {
									url = ctx
											+ "/person/upload!findPage.action?fileTree.id="
											+ node.id+"&status="+status;
								} else {
									url = ctx
											+ "/person/download!findPage.action?fileTree.id="
											+ node.id+"&status="+status;
								}
								$("#shareFileListIframe").attr("src", url)
							},
							onContextMenu : function(e, node) {
								var parentTree = $("#shareMainTree").tree(
										"getParent", node.target);
								if (!parentTree) {
									var item = $('#shareContextMenu').menu(
											'findItem', '删除节点');
									$('#shareContextMenu').menu('disableItem',
											item.target);

								} else {
									var item = $('#shareContextMenu').menu(
											'findItem', '删除节点');
									$('#shareContextMenu').menu('enableItem',
											item.target);
								}
								e.preventDefault();
								$("#shareMainTree").tree('select', node.target);
								$('#shareContextMenu').menu('show', {
									left : e.pageX,
									top : e.pageY
								});

							}
						});
		$("#shareContextMenu").menu({
			onClick : function(item) {
				var type = $(item.target).attr('title');
				if (type === '添加') {
					addShareNodeFn();
				} else if (type === '删除') {
					deleteShareNodeFn();
				} else if (type === '修改') {
					updateShareNodeFn();
				}
			}
		});

	})
	function addShareNodeFn() {
		var node = $("#shareMainTree").tree("getSelected");
		parent.$
				.modalDialog({
					title : "添加节点",
					width : 340,
					height : 140,
					href : ctx + "/person/shareFileTree!toAdd.action?id="
							+ node.id,
					buttons : [
							{
								text : '添加',
								iconCls : 'icon-save',
								handler : function() {
									parent.$.modalDialog.openner_shareFileTree = shareFileTree;
									var f = parent.$.modalDialog.handler
											.find('#shareAddNodeForm');
									f.submit();
								}
							},
							{
								text : '取消',
								iconCls : 'icon-cancel',
								handler : function() {
									parent.$.modalDialog.handler
											.dialog('close');
								}
							} ]
				});
	}
	function deleteShareNodeFn() {
		parent.$.messager
				.confirm(
						"提示",
						"删除此节点也将删除此节点下的所有资源，确认要删除勾选的节点吗？",
						function(r) {
							if (r) {
								var node = $("#shareMainTree").tree(
										"getSelected");
								$
										.ajax({
											type : "POST",
											url : ctx
													+ "/person/shareFileTree!deleteNode.action",
											data : "id=" + node.id,
											success : function(msg) {
												if (msg) {
													shareFileTree
															.tree("reload");
													$.messager.show({
														msg : '删除成功',
														title : '提示'
													});
												}
											}
										});
							}
						});
	}
	function updateShareNodeFn() {
		var node = $("#shareMainTree").tree("getSelected");
		parent.$
				.modalDialog({
					title : "修改节点",
					width : 340,
					height : 140,
					href : ctx + "/person/shareFileTree!toUpdate.action?id="
							+ node.id,
					buttons : [
							{
								text : '保存',
								iconCls : 'icon-save',
								handler : function() {
									parent.$.modalDialog.openner_shareFileTree = shareFileTree;
									var f = parent.$.modalDialog.handler
											.find('#shareUpdateNodeForm');
									f.submit();
								}
							},
							{
								text : '取消',
								iconCls : 'icon-cancel',
								handler : function() {
									parent.$.modalDialog.handler
											.dialog('close');
								}
							} ]
				});
	}
</script>
</head>
<s:hidden name="status" id="status"></s:hidden>
<div id="shareContextMenu" class="easyui-menu">
	<div title="添加" data-options="iconCls:'icon-add'" id="addShareNode">添加节点</div>
	<div title="删除" data-options="iconCls:'icon-remove'"
		id="deleteShareNode">删除节点</div>
	<div title="修改" data-options="iconCls:'icon-edit'" id="updateShareNode">修改节点</div>
</div>

<body class="easyui-layout" data-options="border:false">
	<div data-options="region:'west',title:'资料分类',split:true"
		style="width: 120px;">
		<ul id="shareMainTree" data-options="fit:true,border:false"></ul>
	</div>
	<div data-options="region:'center'">
		<iframe
			<s:if test="@com.lxs.oa.message.common.FileStatusEnum@upload.value==status">
				src="${ctx }/person/upload!findPage.action?status=${status }"   
			</s:if>
			<s:if test="@com.lxs.oa.message.common.FileStatusEnum@download.value==status">
				src="${ctx }/person/download!findPage.action?status=${status }"   
			</s:if>
			id="shareFileListIframe" frameborder="0"
			style="border: 0; width: 100%; height: 98%;"></iframe>
	</div>
</body>
</html>