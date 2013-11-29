<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>投票管理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<body>
	<script type="text/javascript">
		$(function() {
			$(".showVoteResultButton")
					.click(
							function() {
								parent.$
										.modalDialog({
											title : "投票详情",
											width : 650,
											height : 400,
											href : ctx
													+ "/person/vote!toShowVoteDetail.action?id="
													+ $(this).attr("voteId"),
											buttons : [ {
												text : '确定',
												iconCls : 'icon-cancel',
												handler : function() {
													parent.$.modalDialog.handler
															.dialog('close');
												}
											} ]
										});
							})
		})
	</script>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button id="addButton"
					actionUrl="${ctx }/work/voteSubject!toAdd.action"
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
	<form method="post" action="${ctx }/work/voteSubject!delete.action"
		id="deleteForm">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th class="table_checkbox"><input type="checkbox"
						id="checkAllCheckBox"></th>
					<th>标题</th>
					<th>投票范围</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>是否匿名</th>
					<th>类型</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr>
						<td class="table_checkbox"><input type="checkbox" name="ids"
							value="${id }" /></td>
						<td><s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@published.value==status">
								<a href="javascript:void(0)" class="showVoteResultButton"
									voteId="${id }">${title }</a>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@published.value!=status">
						${title }
						</s:if></td>
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
						<td><s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@notPublish.value==status">
								<font color="red">未发布</font>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@published.value==status">
								<font color="green">已发布</font>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@end.value==status">
								<font color="gray">已终止</font>
							</s:if></td>
						<td><s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@notPublish.value==status">
								<A href="${ctx }/work/voteSubject!toUpdate.action?id=${id}">修改</A>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@published.value==status">
								<a href="${ctx }/work/voteSubject!stopVote.action?id=${id}">终止</a>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@end.value==status">
								<a href="${ctx }/work/voteSubject!startVote.action?id=${id}">重新启动</a>
							</s:if> <s:if
								test="@ com.lxs.oa.work.common.VoteStatusEnum@notPublish.value==status">
								<a href="${ctx }/work/voteSubject!publishVote.action?id=${id}">发布</a>
							</s:if></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</form>
	<tags:pagination page="${page }"></tags:pagination>

</body>
</html>
