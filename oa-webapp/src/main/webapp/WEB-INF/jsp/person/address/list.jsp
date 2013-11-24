<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>通讯录</title>
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
				<button id="addButton"
					actionUrl="${ctx }/person/address!toAdd.action?type=${type}"
					class="btn btn-info">
					<span class="glyphicon glyphicon-plus"></span> 新建
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
				action="${ctx}/person/address!findPage.action" method="post">
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="firstName">中文名称：</label></Td>
						<Td class="query_input"><s:textfield name="firstName" placeholder="请输入中文名称"
								cssClass="form-control" id="firstName"></s:textfield></Td>
						<Td class="control-label"><label for="secondName">英文名称：</label></Td>
						<Td class="query_input"><s:textfield name="secondName" placeholder="请输入英文名称"
								cssClass="form-control" id="secondName"></s:textfield></Td>
					</Tr>
					<Tr>
						<Td class="control-label"><label for="companyName">公司名称：</label></Td>
						<Td class="query_input"><s:textfield name="companyName" placeholder="请输入公司名称"
								cssClass="form-control" id="companyName"></s:textfield></Td>
						<Td class="control-label"><label for="fixedPhone">固定电话：</label></Td>
						<Td class="query_input"><s:textfield name="fixedPhone" placeholder="请输入固定电话"
								cssClass="form-control" id="fixedPhone"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<form method="post" action="${ctx }/person/plan!delete.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>中文名称</th>
					<th>英文名称</th>
					<th>公司名称</th>
					<th>固定电话</th>
					<th>手机</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${firstName}</td>
						<td>${secondName }</td>
						<td>${companyName }</td>
						<td>${fixedPhone }</td>
						<td>${mobilPhone }</td>
						<td><a href="${ctx}/person/address!toUpdate.action?id=${id}">修改</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
