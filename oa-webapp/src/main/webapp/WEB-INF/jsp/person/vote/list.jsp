<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>投票列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript" src="${ctx }/js/person-vote-list.js"></script>
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
				action="${ctx}/work/voteSubject!findPage.action" method="post">
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
	<form method="post" action="${ctx }/person/voteSubject!delete.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>

					<th>标题</th>
					<th>发布人</th>
					<th>投票范围</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>是否匿名</th>
					<th>类型</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>

						<td><a href="javascript:void(0)" voteId="${id }"
							class="toVoteButton">${title }</a></td>
						<Td>${owner.realName }</Td>
						<td>${canVoteUsersName }</td>
						<td>${startDate }</td>
						<td><c:if test="${empty endDate }">
								手动结束
							</c:if> <c:if test="${not empty endDate }">
								${endDate }
							</c:if></td>
						<td><c:if test="${anonymous}">
								是
							</c:if> <c:if test="${!anonymous}">
								否
							</c:if></td>
						<td>${voteType.typeName }</td>
						<td><a href="javascript:void(0)" voteId="${id }"
							class="showVoteResultButton">查看详情</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>

</body>
</html>
