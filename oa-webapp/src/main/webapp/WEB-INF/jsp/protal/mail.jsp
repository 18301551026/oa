<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>短消息</title>
<%@include file="/common/global.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<div class="fillet">
		<c:set value="0" var="mnum"></c:set>
		<table align="center" class="index_table" id="messageTable">
			<c:forEach items="${mails }" var="m" begin="0" end="4">
				<c:set value="${mnum+1 }" var="mnum"></c:set>
				<Tr>
					<TD style="width: 50%">
						<a href="${ctx}/person/receiveBox!toShowProtalMail.action?id=${m.id}" onclick="messageClick(event)" class="message_a" actionHref="${basePath }/personalOffice/receivedMessage!toReadDeskTopMessage.action?id=${m.id}"  onclick="messageClick(event)" >
						<c:if test="${fn:length(m.title)>12}">
							${fn:substring(m.title,0,13)}...
						</c:if>
						<c:if test="${fn:length(m.title)<=12}">
							${m.title }
						</c:if>
					</a></TD>
					<TD style="width: 20%" >${m.sendUserName} </TD>
					<TD style="width: 25%;">${m.createDate  }</TD>
				</Tr>
			</c:forEach>
			<c:forEach begin="${mnum }" end="4">
				<Tr>
					<TD colspan="3"></TD>
				</Tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>