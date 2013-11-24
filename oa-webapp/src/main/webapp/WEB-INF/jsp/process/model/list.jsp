<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>模型管理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>

<body>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button id="createModelButton" class="btn btn-info"
					onclick="window.open('${ctx }/process/model!toAdd.action');">
					<span class="glyphicon glyphicon-minus"></span> 添加
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
				action="${ctx}/process/model!findPage.action" method="post">
				<table class="formTable">
					<Tr>

						<Td class="control-label"><label for="endDate">模型名称：</label></Td>
						<Td class="query_input" colspan="3"><s:textfield cssClass="form-control"></s:textfield>
						</Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form action="${ctx }/process/model!delete.action" method="post"
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
					<th>创建时间</th>
					<th>最后更新时间</th>
					<th>元数据</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${id }</td>
						<td>${key }</td>
						<td>${name}</td>
						<td>${version}</td>
						<td>${createTime}</td>
						<td>${lastUpdateTime}</td>
						<td>${metaInfo}</td>
						<td><a href="${ctx }/service/editor?id=${id}" target="_bank">修改</a>
							<a href="${ctx }/process/model!deploy.action?modelId=${id}">部署</a>
							<a href="${ctx }/process/model!export.action?modelId=${id}">导出</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
