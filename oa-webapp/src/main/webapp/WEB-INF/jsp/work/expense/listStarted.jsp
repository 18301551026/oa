<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>报销管理</title>
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
				action="${ctx}/work/expenseStarted!findPage.action" method="post">
				<%-- <s:hidden name="status"></s:hidden> --%>
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="startMoney">最小金额：</label></Td>
						<Td class="query_input"><s:textfield name="startMoney"
								cssClass="form-control" id="startMoney" placeholder="请输入最小金额"></s:textfield></Td>
						<Td class="control-label"><label for="endDate">最大金额：</label></Td>
						<Td class="query_input"><s:textfield name="endMoney"
								cssClass="form-control" id="endMoney" placeholder="请输入最大金额"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form action="${ctx }/work/expense!delete.action" method="post"
		id="deleteForm">
		<s:hidden name="definitionKey"
			value="%{@ com.lxs.process.common.ProcessEnum@expense}"></s:hidden>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>报销金额</th>
					<th>标题</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td>${money}</td>
						<td>${title }</td>
						<td><a
							href="${ctx }/process/instance!watch.action?id=${id}&definitionKey=<s:property value="@ com.lxs.process.common.ProcessEnum@expense"/>">流程跟踪</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
