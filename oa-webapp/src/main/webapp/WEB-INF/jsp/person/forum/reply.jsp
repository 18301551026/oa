<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>论坛回帖</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<script src="${ctx }/js/grid.js"></script>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<body>
	<script type="text/javascript" src="${ctx }/js/forum-reply.js"></script>
	<div class="panel panel-info">
		<div class="panel-heading">
			<div class="btn-group btn-group-sm">
				<button class="btn btn-info"
					onclick="javascript:location.href='${ctx}/person/subject!findPage.action?moduleId=${sub.module.id }';">
					<span class="glyphicon glyphicon-backward"></span> 返回
				</button>
				<button id="saveButton" class="btn btn-info">
					<span class="glyphicon glyphicon-plus"></span> <font id="replyFont">回帖</font>
				</button>
			</div>
			<form action="${ctx }/person/reply!findPage.action" method="post"
				id="queryForm">
				<s:hidden name="subjectId"></s:hidden>
			</form>
		</div>
	</div>
	<div
		style="border-radius: 4px 4px 4px 4px; border: 1px solid #CCCCCC; padding-bottom: 0px; margin-bottom: 5px;">
		<table style="width: 100%;">
			<thead
				style="font-weight: bold; background-color: #e0edff; height: 30px; line-height: 30px; border-bottom: 1px solid #DDDDDD">
				<tr>
					<td colspan="4">${sub.title }</td>
				</tr>
			</thead>
			<tbody>
				<tr
					style="border-bottom: 1px solid #DDDDDD; height: 40px; vertical-align: middle;">
					<td colspan="4">${sub.content }</td>
				</tr>
				<s:iterator value="#page.result">
					<Tr style="border-bottom: 1px dashed #DDDDDD;">
						<Td>
							<table style="width: 100%;">
								<tr>
									<td colspan="3">${title }</td>
									<td align="right">
										<c:if
											test="${user.id!=sessionScope.currentUser.id }">
											<A href="javascript:void(0)" class='replyReplyBtn' replyUserName='${user.realName }'>
										   <span  class="glyphicon glyphicon-saved"></span> 回复</A>&nbsp;</c:if>
										<c:if test="${user.id==sessionScope.currentUser.id }">
										 <A href="javascript:void(0)" class='editReplyBtn' replyId='${id }'>
										  <span  class="glyphicon glyphicon-repeat"></span> 编辑</A>&nbsp;
										 </c:if> 
										 <A href="javascript:void(0)" class='refReplyBtn'>
										  <span  class="glyphicon glyphicon-transfer"></span> 引用</A>&nbsp; 
										 <c:if test="${user.id==sessionScope.currentUser.id }">
											<A href="javascript:void(0)"
												actionUrl='${ctx }/person/reply!delete.action?ids=${id}&subjectId=${subjectId}'
												class='deleteReplyBtn'>
											 <span  class="glyphicon glyphicon-remove"></span> 删除</A>&nbsp;
										</c:if>
									</td>
								</tr>
								<tr>
									<td colspan="4"><font style="width: 40px;">&nbsp;&nbsp;</font>
										<div>${content }</div></td>
								</tr>
								<tr>
									<td align="right" colspan="4">
										${user.realName }&nbsp;${createDate }
									</td>
								</tr>
							</table>
						</Td>
					</Tr>
				</s:iterator>
			</tbody>
		</table>
	</div>
	<tags:pagination page="${page }"></tags:pagination>
	<form action="${ctx}/person/reply!save.action" method="post"
		id="editForm">
		<s:hidden name="subjectId"></s:hidden>
		
		<table class="formTable table">
			<tr>
				<Td class="control-label" style="width: 3%"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入标题" value="回复%{#sub.title}"
						cssClass="form-control validate[required]" id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label" style="width: 3%"><label
					for="content">内容：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="content"
						id="content"></s:textarea></Td>
			</tr>
		</table>
		<a name="targetPlace"></a>
	</form>
</body>
</html>
