<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>论坛模块</title>
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
				action="${ctx}/person/module!findPage.action" method="post">
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
	<div style="border-radius: 4px 4px 4px 4px; border: 1px solid #CCCCCC; padding-bottom: 0px; margin-bottom: 5px;">
		<table class="table">
			<thead style="font-weight: bold;">
				<tr>
					<td align="center">版块</td>
					<td align="center">主题</td>
					<td align="center">帖子</td>
					<td align="center">最后发表</td>
					<td align="center">版主</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#page.result">
					<tr align="center">
						<td><c:if test="${fn:length(subjects)>0}">
								<br />
							</c:if> <a href="${ctx }/person/subject!findPage.action?moduleId=${id }">${title }</a>
						</td>
						<%-- <c:if test="${fn:length(subjects)>0}">
							<br />
						</c:if> --%>
						<td><c:if test="${fn:length(subjects)>0}">
								<br />
							</c:if><b><s:property value="subjects.size" /> </b> <c:if
								test="${fn:length(subjects)>0}">
								<br />
							</c:if>
						</td>
						<td><c:if test="${fn:length(subjects)>0}">
								<br />
							</c:if><b> <c:set var="tnums" value="0"></c:set> <c:forEach
									items="${subjects }" var="t">
									<c:set var="tnums" value="${fn:length(t.replies)+tnums}"></c:set>
								</c:forEach> <c:out value="${tnums }"></c:out>
								</b> <c:if test="${fn:length(subjects)>0}">
								<br />
							</c:if>
						</td>
						<td><c:set var="minDate" value='2010-01-01'>
							</c:set> <c:forEach items="${subjects }" var="t">
								<c:if test="${t.createDate gt minDate}">
									<c:set value="${t.createDate }" var="minDate"></c:set>
								</c:if>
							</c:forEach> <c:forEach items="${subjects }" var="t">
								<c:if test="${t.createDate eq minDate}">
									<ul style="margin: 0px; padding: 0px;list-style: none;">
										<li style="padding-left: 40%"><font color="#444444" style="float: left;">┌ 主题：</font> <a
											href="${ctx }/person/reply!findPage.action?subjectId=${t.id}"
											title="${t.title }" class="ForumTitle" style="float: left;">${t.title}</a><Br/></li>
										<li style="padding-left: 40%"><font color="#444444" style="float: left;">├ 作者：${t.user.realName }</font><Br/></li>
										<li style="padding-left: 40%"><font color="#444444" style="float: left;">└ 时间：${t.createDate }</font><Br/></li>
									</ul>
								</c:if>
							</c:forEach> <c:if test="${minDate eq '2010-01-01'}">
								<font color="#444444">还没有主题</font>
							</c:if>
						</td>
						<td><c:if test="${fn:length(subjects)>0}">
								<br />
							</c:if> <s:property value="user.realName" /> <c:if
								test="${fn:length(subjects)>0}">
								<br />
							</c:if>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</div>
	<tags:pagination page="${page }"></tags:pagination>
</body>
</html>
