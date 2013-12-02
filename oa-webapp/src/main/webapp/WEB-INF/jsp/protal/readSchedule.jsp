<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>查看日程详情</title>
<%@include file="/common/global.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>

</head>
<body>
	<style type="text/css">
form {
	background: none repeat scroll 0 0 #F5F8FA;
	width: 97%;
	height: 94%;
	margin: 0px;
	padding: 10px 5px 5px 5px;
}

.p_label {
	text-align: right;
	vertical-align: middle;
	width: 20%;
}

.p_input {
	width: 75%;
}

input,textarea,.uneditable-input {
	width: 270px;
}

input {
	background-color: #EEEEEE;
	cursor: not-allowed;
	width: 270px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
	border-radius: 4px 4px 4px 4px;
	border: 1px solid #CCCCCC;
	color: #555555;
	font-size: 14px;
	line-height: 20px;
	padding: 4px 6px;
}
textarea {
	background-color: #EEEEEE;
	cursor: not-allowed;
	height: 100px;
	width: 270px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
	border-radius: 4px 4px 4px 4px;
	border: 1px solid #CCCCCC;
	color: #555555;
	font-size: 14px;
	line-height: 20px;
	padding: 4px 6px;
}
</style>
	<form method="post" id="deskToMessageForm">
		<table align="center">
			<Tr>
				<tD class="p_label">开始时间：</tD>
				<Td class="p_input"><s:textfield name="start" readonly="true"></s:textfield></Td>
			</Tr>
			<Tr>
				<tD class="p_label">结束时间：</tD>
				<Td class="p_input"><s:textfield name="end" readonly="true"></s:textfield>
				</Td>
			</Tr>
			<Tr>
				<tD class="p_label">标题：</tD>
				<Td class="p_input"><s:textfield name="title" readonly="true"></s:textfield>
				</Td>
			</Tr>
			<Tr>
				<tD class="p_label">详情：</tD>
				<Td class="p_input"><div>
						<s:textarea readonly="true" name="content"></s:textarea>
					</div></Td>
			</Tr>
		</table>
	</form>
</body>
</html>