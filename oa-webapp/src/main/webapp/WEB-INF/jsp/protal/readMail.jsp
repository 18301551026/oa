<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>阅读短消息</title>
<%@include file="/common/global.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>

</head>
<body>
	<script type="text/javascript">
		$(function() {
			$("#deskToMessageForm").form({
				url : ctx + '/person/receiveBox!protalReplyMail.action',
				onSubmit : function() {
					if ($("#deskToMessageForm").form("validate")) {
						return true;
					} else {
						return false;
					}
				},
				success : function(r) {
					if (!r) {
						return;
					}
					$.messager.show({
						msg : '回复成功',
						title : '提示'
					});
					parent.$.modalDialog.handler.dialog('close');
				}
			});

		})
	</script>
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

.readyOneyDiv {
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

.inp {
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
</style>
	<form method="post" id="deskToMessageForm">
		<table align="center">
			<Tr>
				<tD class="p_label">标题：</tD>
				<Td class="p_input">
					<div class="inp">${title }</div>				
				</Td>
			</Tr>
			<Tr>
				<tD class="p_label">发送时间：</tD>
				<Td class="p_input">
					<div class="inp">${createDate }</div>				
				</Td>
			</Tr>
			<tr>
				<tD class="p_label">附件：</tD>
				<Td class="p_input"><c:forEach items="${attachments }"
						var="att">
						<a
							href="${ctx }/person/receiveBox!download.action?attId=${att.id}">${att.attName }</a>
					</c:forEach></Td>
			</tr>
			<Tr>
				<tD class="p_label">内容：</tD>
				<Td class="p_input">
					<div class="readyOneyDiv">${content }</div>
				</Td>
			</Tr>

			<Tr>
				<tD class="p_label">回复： <input type="hidden" name="title"
					value="回复${sendUserName}"> <input type="hidden"
					name="mailId" value="${id }" /> <input type="hidden"
					value="${sendUserName }" name="receiveUsersName">
				</tD>
				<Td><textarea name="content" class="easyui-validatebox"
						data-options="required:true"></textarea></Td>
			</Tr>

		</table>
	</form>
</body>
</html>