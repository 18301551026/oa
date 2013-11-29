<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>投票结果</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<style>
table {
	border-collapse: collapse;
}
</style>
	<div align="center"
		style="margin-top: 10px; background-color: #FFFFFF; height: 90%; width: 100%;">
		<table width="88%" style="margin-bottom: 10px;">
			<thead
				style="margin-bottom: 12px; background-color: #E0ECFF; font-size: 15px; text-align: left; line-height: 30px;">
				<th align="center">
				<TD colspan="3"><s:property value="title" /></TD>
				</th>
			</thead>

			<tbody style="">
				<s:iterator value="options">
					<tr
						style="border-bottom: 1px solid #95B8E7; margin-bottom: 12px; text-align: left; line-height: 25px;">
						<Td width="40%">${optionName }</Td>
						<Td width="55%">
							<div
								style="background-color: #95B8E7;width:<c:if test="${percent>=1 }"><s:property value='percent' /></c:if><c:if test="${percent==null||percent==0 }">0</c:if>%;height:20px;">
								${percent }%</div>
						</Td>
						<Td width="5%" style="text-align: right;"><c:if
								test="${nums>=1 }">
							${nums }
							</c:if> <c:if test="${nums==null }">
							0
							</c:if>票</Td>
					</tr>
				</s:iterator>

			</tbody>
			<s:if test="anonymous">
				<tfoot>
					<th style="float: left;">共有<s:property value="hadUserVoteNum" />人投票
					</th>
				</tfoot>
			</s:if>
		</table>
		<s:if test="!anonymous">
			<table width="88%">
				<thead
					style="border-bottom: 1px solid #0E2D5F; margin-bottom: 12px; background-color: #95B8E7; font-size: 15px; text-align: left; line-height: 30px;">
					<th colspan="2" align="center">共有<s:property
							value="hadUserVoteNum" />人投票
					</th>
				</thead>
				<tbody style=""1pxsolid #95B8E7;">
					<s:iterator value="options">
						<tr
							style="border-bottom: 1px solid #E0ECFF; margin-bottom: 12px; text-align: left; line-height: 25px;">
							<Td width="40%">${optionName }</Td>
							<Td width="60%"><c:forEach items="${users }" var="u">
								${u.realName }&nbsp;
							</c:forEach></Td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</s:if>
	</div>
</body>
</html>