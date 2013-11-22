<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>选择接收人</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<script type="text/javascript">
		var selectedUsers = document.getElementById('selectedUsers');
		var receivedUserNames = document.getElementById('receiveUsersName');
		var ids = document.getElementById('ids');
		$(function() {
			var seleceUserByDept = document.getElementById('seleceUserByDept');
			var allUsers = document.getElementById('allUsers');
			var allDept = document.getElementById('allDept');
			$("#selectedUsers")
					.dblclick(
							function() {
								for (var i = selectedUsers.options.length - 1; i >= 0; i--) {
									if (selectedUsers.options[i].selected) {
										selectedUsers.remove(i);
										/* console.info(selectedUsers.options[i].value); */
										var values = getValue(selectedUsers);
										ids.value = values.substr(0,
												values.length - 1);
										var texts = getText(selectedUsers);
										receivedUserNames.value = texts.substr(
												0, texts.length - 1);
										console.info(ids.value);
									}
								}
							});
			$("#seleceUserByDept").dblclick(function() {
				moveOptions(seleceUserByDept, selectedUsers);
			})
			$("#allUsers").dblclick(function() {
				moveOptions(allUsers, selectedUsers);
			})
			$("#allDept").dblclick(function() {
				moveOptions(allDept, selectedUsers);
			})

			$(".searchbox-button").live('click', function() {
				var name = $("#searchuserbox").searchbox("getValue");
				$.ajax({
					type : "post",
					url : ctx + "/security/user!findUserByName.action",
					data : "realName=" + name,
					success : function(html) {
						document.getElementById("allUsers").innerHTML = html;
					}
				});
			})

			$("#setCanDownloadUsersForm").form({
				url : ctx + '/person/shareFile!confirmCanDownloadUsers.action',
				success : function(r) {
					if (!r) {
						return;
					}
					$.messager.show({
						msg : '设置成功',
						title : '提示'
					});
					//	parent.$.modalDialog.openner_shareFileTree.tree('reload');
					parent.parent.$.modalDialog.handler.dialog('close');
				}
			});
		})
		function moveOptions(e1, e2) {
			for (var i = e1.options.length - 1; i >= 0; i--) {
				if (e1.options[i].selected) {
					var e = e1.options[i];
					var flag = false;
					for (var j = e2.options.length - 1; j >= 0; j--) {
						var ee = e2.options[j];
						if (ee.value == e.value) {
							flag = true;
						}
					}
					if (!flag) {
						e2.options.add(new Option(e.text, e.value),
								e2.options.length);

					}

				}
			}
			var value = getValue(selectedUsers);
			var text = getText(selectedUsers);
			ids.value = value.substr(0, value.length - 1);
			receivedUserNames.value = text.substr(0, text.length - 1);
		}
		function getValue(list) {
			if (!list) {
				return '';
			}
			var value = "";
			for (var i = 0; i < list.options.length; i++) {
				value += list.options[i].value + ",";
			}
			if (value.length < 1) {
				return '';
			} else {
				return value;
			}

		}
		function getText(list) {
			if (!list) {
				return '';
			}
			var text = "";
			for (var i = 0; i < list.options.length; i++) {
				text = text + list.options[i].text + ",";
			}
			if (text.length < 1) {
				return '';
			} else {
				return text;
			}

		}
		function selectDeptToShowUserfn() {
			var seleceUserByDept = document.getElementById('seleceUserByDept');
			var id = $("#selectDeptToShowUser").val();
			$
					.ajax({
						type : "POST",
						url : ctx + "/person/sendBox!findUserByDept.action",
						data : "deptId=" + id,
						success : function(html) {
							document.getElementById("seleceUserByDept").innerHTML = html;
						}

					});
		}
	</script>
	<form action="" method="post" id="setCanDownloadUsersForm">
		<s:hidden id="ids" name="canDownloadUserIds"></s:hidden>
		<s:hidden name="canDownloadUsersName" id="receiveUsersName"></s:hidden>
	</form>
	<div class="easyui-layout" data-options="fit:true,border:false">

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