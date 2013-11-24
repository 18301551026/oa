<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>请假管理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<body>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button id="addButton" class="btn btn-info" actionUrl="${ctx }/work/leave!toAdd.action">
					<span class="glyphicon glyphicon-plus"></span> 新建
				</button>
				<button id="startButton" class="btn btn-info" actionUrl="${ctx }/work/leave!start.action">
					<span class="glyphicon glyphicon-plus"></span> 启动
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
				action="${ctx}/work/leave!findPage.action" method="post">
				<s:hidden name="status"></s:hidden>
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="startDate">开始日期：</label></Td>
						<Td class="query_input"><s:textfield name="startDate"
								onclick="WdatePicker()" cssClass="form-control" id="startDate"
								readonly="true" placeholder="请选择开始日期"></s:textfield></Td>
						<Td class="control-label"><label for="endDate">结束日期：</label></Td>
						<Td class="query_input"><s:textfield name="endDate"
								onclick="WdatePicker()" cssClass="form-control" id="endDate"
								readonly="true" placeholder="请选择结束日期"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form action="${ctx }/work/leave!delete.action" method="post"
		id="deleteForm">
		<s:hidden name="definitionKey"
			value="%{@ com.lxs.process.common.ProcessEnum@leave}"></s:hidden>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>请假天数</th>
					<th>开始时间</th>
					<th>状态</th>
					<th>标题</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${days}</td>
						<td>${startDate }</td>
						<td>${status }</td>
						<td>${title }</td>
						<td><a href="${ctx}/work/leave!toUpdate.action?id=${id}">修改</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>

</body>
</html>
