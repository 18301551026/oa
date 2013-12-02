<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>我的日程</title>
<%@include file="/common/global.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<div class="fillet">
		<c:set value="0" var="snum"></c:set>
		<table align="center" class="index_table">
			<c:forEach items="${schedules }" var="schedule">
				<c:set var="snum" value="${snum+1 }"></c:set>
				<tr>
					<TD style="width: 55%"><a
						href="${ctx }/person/schedule!toShowProtalScheduleDetail.action?id=${schedule.id}"
						onclick="scheduleClick(event)"> <c:if
								test="${fn:length(schedule.title)>12}">
							${fn:substring(schedule.title,0,13)}...
						</c:if> <c:if test="${fn:length(schedule.title)<=12}">
							${schedule.title }
						</c:if>
					</a></TD>
					<TD style="width: 40%" align="right">
						<c:if test="${schedule.allDay}">
							全天
						</c:if>
						<c:if test="${!schedule.allDay}">
					${fn:substring(schedule.start,11, -1)}-${fn:substring(schedule.end,11, -1)}		
						</c:if>
					</TD>
				</tr>
			</c:forEach>
			<c:forEach begin="${snum }" end="4">
				<Tr>
					<TD colspan="2"></TD>
				</Tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>