<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>流程管理</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>

<body>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
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
				action="${ctx}/process/definition!findPage.action" method="post">
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="definitionName">流程名称：</label></Td>
						<Td class="query_input"><s:textfield name="definitionName"
								cssClass="form-control" id="definitionName"
								placeholder="请输入流程名称"></s:textfield></Td>
						<Td class="control-label"><label for="endDate">流程列表：</label></Td>
						<Td class="query_input"><s:select name="definitionKey"
								cssClass="form-control"
								list="@ com.lxs.process.common.ProcessEnum@values()"
								listValue="value" headerKey="" headerValue="全部"></s:select></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form action="${ctx }/process/definition!delete.action" method="post"
		id="deleteForm">
		
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>Id</th>
					<th>Name</th>
					<th>Key</th>
					<th>Version</th>
					<th>ResourceName</th>
					<th>DeploymentId</th>
					<th>DiagramResourceName</th>
					<th>Suspended</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${id }</td>
						<td>${name }</td>
						<td>${key }</td>
						<td>${version }</td>
						<td>${resourceName }</td>
						<td>${deploymentId }</td>
						<td>${diagramResourceName }</td>
						<td>${suspended }</td>
						<td><a
							href="${ctx}/process/definition!convert2Model.action?definitionId=${id}"
							target="_bank">转换模型</a> <a
							href="${ctx}/process/definition!toUpload.action?definitionKey=${key}">上传表单</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>

</body>
</html>
