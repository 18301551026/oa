<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>新闻</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-1.8.0.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript">
	$(function() {
		$("#checkAllCheckBox").click(function() {
			alert($(this).attr("checked"));
			if ($(this).attr("checked")) {
				$(":checkbox[name='ids']").attr("checked", true);
			} else {
				$(":checkbox[name='ids']").attr("checked", false);
			}

		});
	});
</script>
<body>

	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="btn-group">
				<button id="addButton" actionUrl="${ctx }/message/news!toAdd.action"
					class="btn btn-default">新建</button>
				<button id="deleteButton" class="btn btn-default">删除</button>
				<button id="queryButton" class="btn btn-default">查询</button>
			</div>
			<a href="javascript:void(0)" title="查询表单"
				id="showOrHideQueryPanelBtn"><span
				class="glyphicon glyphicon-chevron-down pull-right"></span></a> <label
				class="pull-right">查询条件</label>
		</div>
		<div class="panel-body hide" id="queryPanel">
			<form role="form" id="queryForm" class="form-horizontal"
				action="${ctx}/message/news!findPage.action" method="post">
				<div class="form-group">
					<label for="dictionarys" class="col-sm-1 control-label">类型：</label>
					<div class="col-sm-5">
						<s:select list="dictionarys" id="dictionarys"
							cssClass="form-control" listKey="name" listValue="value"
							headerKey="" headerValue="全部" name="type"></s:select>
					</div>
					<label for="inputNewsTitle" class="col-sm-1 control-label">标题：</label>
					<div class="col-sm-5">
						<s:textfield cssClass="form-control" name="title"
							id="inputNewsTitle" placeholder="请输入标题"></s:textfield>
					</div>
				</div>
			</form>
		</div>
	</div>
	<form method="post">
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox" id="checkAllCheckBox"></th>
					<th>类型</th>
					<th>标题</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td>${type}</td>
						<td>${title }</td>
						<td><a href="${ctx}/message/news!toUpdate.action?id=${id}">修改</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
