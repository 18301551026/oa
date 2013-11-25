<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>选择接收人</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>


</head>
<body>
	<script type="text/javascript" src="${ctx }/js/mail-selectReceiveUsers.js"></script>
		
	<div class="easyui-layout" data-options="fit:true,border:false">
		<s:hidden id="ids" name="receiveUserIds"></s:hidden>
		<s:hidden name="receiveUsersName" id="receiveUsersName"></s:hidden>
		<div data-options="region:'west'" class="easyui-accordion"
			style="width: 150px;" data-options="border:false">
			<div title="所有人员列表" style="border: none;">
				<input id="searchuserbox" class="easyui-searchbox"
					style="width: 144px;"></input> <select multiple="multiple"
					class="selectUser" id="allUsers"
					style="width: 144px; height: 90%; border: none;">
					<c:forEach items="${users }" var="u">
						<option value="${u.id }">${u.realName }</option>
					</c:forEach>
				</select>
			</div>
			<div title="按部门选择人员">
				<select style="width: 144px;" onchange="selectDeptToShowUserfn()"
					id="selectDeptToShowUser">
					<c:forEach items="${depts }" var="d">
						<option value="${d.id }">${d.deptName }</option>
					</c:forEach>
				</select> <select multiple="multiple" id="seleceUserByDept"
					style="width: 144px; height: 90%; border: none;">
				</select>
			</div>
			<div title="选择部门" data-options="selected:true,border:false">
				<select multiple="multiple" id="allDept"
					style="width: 144px; height: 95%; border: none;">
					<c:forEach items="${depts }" var="d">
						<option value="d${d.id }">${d.deptName }</option>
					</c:forEach>
				</select>
			</div>

		</div>
		<div data-options="region:'center'">
			<select multiple="multiple" id="selectedUsers"
				style="width: 132px; height: 97%; border: none;">
				<c:if test="${null!=selectedMailUsers }">
					<c:forEach items="${selectedMailUsers }" var="u">
						<option value="${u.user.id }">${u.user.realName }</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
	</div>

</body>
</html>