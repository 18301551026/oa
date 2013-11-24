<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>历史流程管理</title>
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
				action="${ctx}/security/dept!findPage.action" method="post">
				<table class="formTable">
					<Tr>

						<Td class="control-label"><label for="endDate">流程列表：</label></Td>
						<Td class="query_input" colspan="3"><s:select
								name="definitionKey" cssClass="form-control"
								list="@ com.lxs.process.common.ProcessEnum@values()"
								listValue="value" headerKey="" headerValue="全部"></s:select></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form action="${ctx }/process/history!delete.action" method="post"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>Id</th>
					<th>businessKey</th>
					<th>processDefinitionId</th>
					<th>StartTime</th>
					<th>EndTime</th>
					<th>DurationInMillis</th>
					<th>EndActivityId</th>
					<th>StartActivityId</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${id }</td>
						<td>${businessKey }</td>
						<td>${processDefinitionId }</td>
						<td><s:date name="startTime" var="formatStartTime"
								format="yyyy-MM-dd HH:mm:ss" /> <s:property
								value="formatStartTime" /></td>
						<td><s:date name="endTime" var="formatEndTime"
								format="yyyy-MM-dd HH:mm:ss" /> <s:property
								value="formatEndTime" /></td>
						<td>${durationInMillis }</td>
						<td>${endActivityId }</td>
						<td>${startActivityId }</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
