<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>添加日程</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>

</head>

<body>
	<style type="text/css">
.form-control-mini {
	background-color: #FFFFFF;
	border: 1px solid #CCCCCC;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	color: #555555;
	display: block;
	font-size: 12px;
	height: 25px;
	line-height: 1.42857;
	padding: 2px;
	transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s
		ease-in-out 0s;
	vertical-align: middle;
	width: 100%;
}

#scheduleEditTable .lbl {
	width: 15%;
	text-align: right;
	vertical-align: middle;
}

#scheduleEditTable .input {
	width: 75%;
}

textarea {
	overflow: auto;
	vertical-align: top;
}

textarea.form-control-mini {
	height: 100px;
}

.form-control-mini:focus {
	border-color: #66AFE9;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px
		rgba(102, 175, 233, 0.6);
	outline: 0 none;
}

.form-control-mini[disabled],.form-control-mini[readonly],fieldset[disabled] .form-control-mini
	{
	background-color: #EEEEEE;
	cursor: not-allowed;
}
</style>
	<script type="text/javascript" src="${ctx }/js/schedule-edit.js"></script>
	<div align="center"
		style="position: relative; font-size: 12px; padding-top: 10px; background-color: #F5F8FA; height: 96%; width: 100%;">
		<form action="" method="post" id="editForm">
		<s:hidden name="id"></s:hidden>
			<table id="scheduleEditTable">
				<tr>
					<Td class="lbl"><label for="strStartDate">开始时间：</label></Td>
					<Td class="input"><s:textfield id="strStartDate"
							name="strStartDate" readonly="true" cssClass="form-control-mini"></s:textfield></Td>
				</tr>
				<tr>
					<Td class="lbl"><label for="strEndDate">结束时间：</label></Td>
					<Td class="input"><s:textfield name="strEndDate"
							id="strEndDate" readonly="true" cssClass="form-control-mini"></s:textfield></Td>
				</tr>
				<Tr>
					<td class="lbl"><label for="title">标题：</label></td>
					<Td class="input"><s:textfield name="title" id="title"
							cssClass="form-control-mini easyui-validatebox"
							data-options="required:true"></s:textfield></Td>
				</Tr>
				<tr>
					<Td class="lbl"><label for="content">内容：</label></Td>
					<Td class="input"><s:textarea name="content" id="content"
							cssClass="form-control-mini"></s:textarea></Td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>