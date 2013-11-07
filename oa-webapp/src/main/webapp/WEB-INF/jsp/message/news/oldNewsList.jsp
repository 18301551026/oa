<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <div class="container">
		<div class="btn-group pull-right">
			<button id="addButton" actionUrl="${ctx }/message/news!toAdd.action"
				class="btn btn-default">新建</button>
			<button id="deleteButton" class="btn btn-default">删除</button>
			<button id="queryButton" class="btn btn-default">查询</button>
		</div>
		<div class="clearfix"></div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label class="pull-left">查询条件</label>
				<a href="javascript:void(0)" title="查询表单"
					id="showOrHideQueryPanelBtn"><span
					class="glyphicon glyphicon-chevron-down pull-right"></span></a>
			</div>
			<div class="panel-body hide" id="queryPanel">
				<form role="form" id="queryForm" class="form-horizontal"
					action="${ctx}/message/news!findPage.action" method="post">
					<div class="form-group">
						<label for="dictionarys" class="col-sm-2 control-label" >类型：</label>
						<div class="col-sm-9">
							<s:select list="dictionarys" id="dictionarys"
								cssClass="form-control" listKey="name" listValue="value"
								headerKey="" headerValue="全部" name="type"></s:select>
						</div>
					</div>
					<div class="form-group">
						<label for="inputNewsTitle" class="col-sm-2 control-label">标题：</label>
						<div class="col-sm-9">
							<s:textfield cssClass="form-control" name="title"
								id="inputNewsTitle" placeholder="请输入标题"></s:textfield>
						</div>
					</div>
				</form>
			</div>

		</div>

		<!-- 表格 -->
		<form id="deleteForm" action="${ctx }/message/news!delete.action">
			<div class="table-responsive">
				<table
					class="table table-bordered table-hover table-striped table-condensed">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAllCheckBox"></th>
							<th>类型</th>
							<th>标题</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="#page.result">
							<tr>
								<td><input type="checkbox" name="ids" value="${id }" /></td>
								<td>${type}</td>
								<td>${title }</td>
								<td><a href="${ctx}/message/news!toUpdate.action?id=${id}">修改</a></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
		</form>
		<tags:pagination page="${page }"></tags:pagination>
	</div> --%>
</body>
</html>