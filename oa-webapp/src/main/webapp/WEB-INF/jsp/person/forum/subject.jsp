<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>论坛主题</title>
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
				<button class="btn btn-info"
					onclick="javascript:location.href='${ctx}/person/module!findPage.action';">
					<span class="glyphicon glyphicon-backward"></span> 返回
				</button>
				<button id="addButton"
					actionUrl="${ctx }/person/subject!toAdd.action?moduleId=${moduleId}"
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
				action="${ctx}/person/subject!findPage.action" method="post">
				<s:hidden name="moduleId"></s:hidden>
				<table class="formTable">
					<Tr>
						<Td class="control-label"><label for="title">名称：</label></Td>
						<Td class="query_input"><s:textfield name="title"
								cssClass="form-control" id="title"></s:textfield></Td>
					</Tr>
				</table>
			</form>
		</div>
	</div>
	<div
		style="border-radius: 4px 4px 4px 4px; border: 1px solid #CCCCCC; padding-bottom: 0px; margin-bottom: 5px;">
		<form action="${ctx }/person/subject!delete.action" method="post" id="deleteForm">
		<s:hidden name="moduleId"></s:hidden>
			<table class="table">
				<thead style="font-weight: bold;">
					<tr>
						<td class="table_checkbox"><input type="checkbox"
							id="checkAllCheckBox"></td>
						<td align="center">名称</td>
						<td align="center">所属板块</td>
						<td align="center">帖子</td>
						<td align="center">创建时间</td>
						<td align="center">楼主</td>
						<td align="center">操作</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="#page.result">
						<tr align="center">
							<td class="table_checkbox"><c:if
									test="${user.id==sessionScope.currentUser.id }">
									<input type="checkbox" name="ids" value="${id }" />
								</c:if></td>
							<td><A
								href="${ctx }/person/reply!findPage.action?subjectId=${id}">${title }</A>
							</td>
							<Td>${module.title }</Td>
							<td>${fn:length(replies) }个</td>
							<td>${createDate }</td>
							<td>${user.realName }</td>
							<Td><a
								href="${ctx }/person/subject!toUpdate.action?id=${id}">修改</a></Td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</form>
	</div>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
