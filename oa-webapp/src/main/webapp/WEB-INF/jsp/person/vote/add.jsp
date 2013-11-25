<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>投票添加</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-bootstap.jsp"%>
<%@ include file="/common/include-jquery-validation.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
<%@ include file="/common/include-jquery-kindeditor.jsp"%>
<script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
<%@ include file="/common/include-styles.jsp"%>
</head>
<script type="text/javascript" src="${ctx }/js/vote-add.js"></script>

<body class="editBody">
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
	<form action="${ctx}/person/voteSubject!save.action" method="post"
		id="editForm">
		<table class="formTable table">
			<tr>
				<Td class="control-label"><label for="title">标题：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield name="title"
						placeholder="请输入标题" cssClass="form-control validate[required]"
						id="title"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="startDate">开始时间：</label></Td>
				<Td class="query_input"><s:textfield name="startDate"
						placeholder="请选择开始时间" cssClass="form-control validate[required]"
						readonly="true" id="startDate"></s:textfield></Td>
				<Td class="control-label"><label for="endDate">结束时间：</label></Td>
				<Td class="query_input"><s:textfield name="endDate"
						placeholder="请选择结束时间" cssClass="form-control" id="endDate"
						readonly="true"></s:textfield></Td>
			</tr>
			<tr>
				<Td class="control-label"><label for="typeId">投票类型：</label></Td>
				<Td class="query_input"><select name="voteType.id"
					class="form-control validate[required]" placeholder="请选择投票类型"
					id="typeId">
						<c:forEach items="${types }" var="t">
							<option value="${t.id }">${t.typeName }</option>
						</c:forEach>
				</select></Td>
				<Td class="control-label"><label for="anonymous">是否匿名：</label></Td>
				<Td class="query_input"><select name="anonymous" id="anonymous"
					class="form-control validate[required]" placeholder="请选择是否匿名">
						<option value="true">是</option>
						<option value="false">否</option>
				</select></Td>
			</tr>
			<Tr>
				<Td class="control-label"><label for="canVoteUsersName">投票范围：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="canVoteUsersName" id="canVoteUsersName"
						cssClass="form-control validate[required] pull-left" readonly="true"  cssStyle="width:95%" placeholder="请选择投票范围"></s:textfield>
					<input class="btn btn-info btn-xs pull-right" id="addOption"
					value="添加" type="button" /></Td>
			</Tr>
			<Tr>
				<Td class="control-label"><label for="voteOptions">投票选项：</label></Td>
				<Td class="query_input" colspan="3"><s:textfield
						name="voteOptions"
						cssClass="form-control validate[required] pull-left"
						placeholder="请输入投票选项" cssStyle="width:95%"></s:textfield> <input
					class="btn btn-info btn-xs pull-right" id="addOption" value="添加"
					type="button" /></Td>
			</Tr>
			<Tr>
				<Td class="control-label"><label for="desc">描述：</label></Td>
				<Td class="query_input" colspan="3"><s:textarea name="desc"
						id="desc"></s:textarea></Td>
			</Tr>
		</table>
	</form>
</body>
</html>
