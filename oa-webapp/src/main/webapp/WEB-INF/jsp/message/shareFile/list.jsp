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
	function confirmCanDownloadUsersFn(fileId, canIds) {
		$.ajax({
			type : "POST",
			url : ctx + "/person/upload!confirmCanDownloadUsers.action",
			data : "id=" + fileId + "&canDownloadUserIds=" + canIds,
			success : function(msg) {
				parent.parent.$.modalDialog.handler.dialog('close');
				parent.parent.$.messager.alert('设置权限', '设置成功');
			}
		});
	}
	$(function() {
		$(".setCanDownloadButton")
				.click(
						function() {
							var fileId = $(this).attr("fileId");
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
														confirmCanDownloadUsersFn(
																fileId, 0);
													}
												},
												{
													text : '确定',
													iconCls : 'icon-save',
													handler : function() {
														var ids = parent.parent.$.modalDialog.handler
																.find('#ids')
																.val();
														console.info(ids + "\t"
																+ fileId);
														confirmCanDownloadUsersFn(
																fileId, ids);
													}
												} ]
									});
						})
		$("#uploadFileButton")
				.click(
						function() {
							if (!$("#fileTreeId").val()) {
								parent.parent.$.messager.alert('警告', '请选择资料分类');
								return;
							}
							parent.parent.$
									.modalDialog({
										title : "上传资源",
										width : 340,
										height : 140,
										href : ctx
												+ "/person/upload!toUpload.action?fileTree.id="
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
				<s:if
					test="status==@com.lxs.oa.message.common.FileStatusEnum@upload.value">
					<button id="uploadFileButton" class="btn btn-info">
						<span class="glyphicon glyphicon-plus"></span> 上传
					</button>
					<button id="deleteButton" class="btn btn-info">
						<span class="glyphicon glyphicon-minus"></span> 删除
					</button>
				</s:if>
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
				<s:if test="status==@com.lxs.oa.message.common.FileStatusEnum@upload.value">
			action="${ctx}/person/upload!findPage.action" 
			</s:if>
				<s:if test="status==@com.lxs.oa.message.common.FileStatusEnum@download.value">
			action="${ctx}/person/download!findPage.action"
			</s:if>
				method="post">
				<s:hidden name="fileTree.id" id="fileTreeId"></s:hidden>
				<s:hidden name="status"></s:hidden>
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
	<form method="post" action="${ctx }/person/upload!delete.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<s:set name="tempStatus" value="status" scope="request"></s:set>
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
						<td><c:if test="${requestScope.tempStatus==1 }">
								<a href="javascript:void(0)"
									actionUrl="${ctx}/person/upload!toSelectCanDownloadUsers.action?id=${id}"
									class="setCanDownloadButton" fileId=${id }>设置权限</a>&nbsp;
						</c:if> <a href="${ctx }/person/download!download.action?id=${id}">下载</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>