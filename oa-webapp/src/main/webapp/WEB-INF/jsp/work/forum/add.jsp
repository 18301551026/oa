<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>论坛模块添加</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<body class="editBody">
<script type="text/javascript" src="${ctx }/js/module.js"></script>
	<button class="btn btn-info btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<div class="btn-group pull-right btn-group-sm">
		<button type="button" class="btn btn-info" id="saveButton">
			<span class="glyphicon glyphicon-ok"></span> 保存
		</button>
		<button type="button" class="btn btn-info" id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/work/module!save.action" method="post"
		id="editForm">
		<!-- 隐藏域：用于保存可见范围ids-->
		<s:hidden name="canWatchUserIds" id="ids"></s:hidden>
		<table class="formTable table">
			<tr>
				<Td class="control-label" style="width:3%"><label for="title">名称：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入名称" cssClass="form-control validate[required]"
						id="title"></s:textfield></Td>
			</tr>
			<Tr>
				<Td class="control-label" style="width:3%"><label for="canWathUserNames">可见人员：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="canWathUserNames" id="canWathUserNames"
						cssClass="form-control validate[required] pull-left" readonly="true"  cssStyle="width:95%" placeholder="请选择可见人员"></s:textfield>
					<input class="btn btn-info btn-xs pull-right"
					value="选择" id="selectCanWatchUsersButton" type="button" /></Td>
			</Tr>
			<Tr>
				<Td class="control-label" style="width:3%"><label for="desc">描述：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="desc"
						id="desc"></s:textarea></Td>
			</Tr>
		</table>
	</form>
</body>
</html>
