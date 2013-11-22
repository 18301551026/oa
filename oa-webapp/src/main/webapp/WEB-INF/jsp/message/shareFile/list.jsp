<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>资源列表</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript">
	$(function() {
		$(".setCanDownloadButton")
				.click(
						function() {
							parent.parent.$
									.modalDialog({
										title : "设置可下载人员",
										width : 300,
										height : 500,
										href : $(this).attr("actionUrl"),
										buttons : [
												{
													text : '全体人员',
													handler : function() {
														$("#ids").val(0);
														$("#receiveUsersName")
																.val("全体人员");
														parent.$.modalDialog.handler
																.dialog('close');
													}
												},
												{
													text : '确定',
													iconCls : 'icon-save',
													handler : function() {
														var ids = parent.$.modalDialog.handler
																.find('#ids');
														var receivedUserNames = parent.$.modalDialog.handler
																.find('#receiveUsersName');
														$("#receiveUsersName")
																.val(
																		receivedUserNames
																				.val());
														$("#ids")
																.val(ids.val());
														parent.$.modalDialog.handler
																.dialog('close');
													}
												} ]
									});
						})
		$("#uploadFileButton")
				.click(
						function() {
							parent.parent.$
									.modalDialog({
										title : "上传资源",
										width : 340,
										height : 140,
										href : ctx
												+ "/person/shareFile!toUpload.action?fileTree.id="
												+ $("#fileTreeId").val(),
										buttons : [
												{
													text : '上传',
													iconCls : 'icon-save',
													handler : function() {
															parent.parent.$.modalDialog.openner_queryForm = $("#queryForm");
														var f = parent.parent.$.modalDialog.handler
																.find('#uploadShareFileForm');
														f.submit();
													}
												},
												{
													text : '取消',
													iconCls : 'icon-cancel',
													handler : function() {
														parent.parent.$.modalDialog.handler
																.dialog('close');
													}
												} ]
									});
						})
	})
</script>
<body>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button id="uploadFileButton" class="btn btn-info">
					<span class="glyphicon glyphicon-plus"></span> 上传
				</button>
				<button id="deleteButton" class="btn btn-info">
					<span class="glyphicon glyphicon-minus"></span> 删除
				</button>
				<button id="queryButton" class="btn btn-info">
					<span class="glyphicon glyphicon-search"></span> 查询
				</button>
			</div>
			<div class="pull-right" style="margin-top: 6px;">
				<a href="javascript:void(0)" title="查询表单"
					id="showOrHideQueryPanelBtn"><span
					class="glyphicon glyphicon-chevron-down pull-right"></span> 查询条件</a>
			</div>
		</div>
		<div class="panel-body hide" id="queryPanel">
			<form role="form" id="queryForm" class="form-horizontal"
				action="${ctx}/person/shareFile!findPage.action" method="post">
				<s:hidden name="fileTree.id" id="fileTreeId"></s:hidden>
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="title">标题：</label></Td>
						<Td class="query_input"><s:textfield name="title"
								cssClass="form-control" id="title"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form method="post" action="${ctx }/person/shareFile!delete.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>名称</th>
					<th>上传人</th>
					<th>上传时间</th>
					<th>大小</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${fileName }</td>
						<td>${ownerUser.realName }</td>
						<Td>${uploadDate }</Td>
						<td>${size }</td>
						<td><a href="javascript:void(0)"
							actionUrl="${ctx}/person/shareFile!toSelectCanDownloadUsers.action?id=${id}"
							class="setCanDownloadButton">设置权限</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>