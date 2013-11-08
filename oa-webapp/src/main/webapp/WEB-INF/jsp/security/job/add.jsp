<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>职位添加</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<script type="text/javascript" src="${ctx }/js/edit.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<%@ include file="/common/include-styles.jsp"%>
</head>

<body>

	<button class="btn btn-default btn-sm pull-left" id="backButton">
		<span class="glyphicon glyphicon-backward"></span> 返回列表
	</button>
	<div class="btn-group pull-right btn-group-sm">
		<button type="button" class="btn btn-default" id="saveButton">
			<span class="glyphicon glyphicon-ok"></span> 保存
		</button>
		<button type="button" class="btn btn-default" id="resetButton">
			<span class="glyphicon glyphicon-repeat"></span> 重置
		</button>
	</div>
	<div class="clearfix" style="margin-bottom: 20px;"></div>
	<form action="${ctx}/security/job!save.action" method="post"
		id="editForm">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="jobName">职位名称：</label></Td>
				<Td class="query_input" colspan="2"><s:textfield name="jobName"
						placeholder="请输入职位名称" cssClass="form-control validate[required]"
						id="jobName"></s:textfield></Td>
			</tr>

		</table>
	</form>
</body>
</html>
