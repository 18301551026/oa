<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>OA协同办公系统</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<script type="text/javascript">
	var modifyPasswordDialog;
	var main_layout;
	var index_tabs;
	var index_tabsMenu;
	var setting = {
		callback : {
			onClick : zTreeOnClick
		}
	};
	$(function() {
		$.post('${ctx}/security/menu!findMenuByUser.action', function(data) {
			var nodes = eval(data);
			$.fn.zTree.init($("#treeMenu"), setting, nodes);
		});
		main_layout = $("#main_layout").layout({
			fit : true
		});

		index_tabs = $('#index_tabs').tabs({
			fit : true,
			border : false,
			onContextMenu : function(e, title, index) {
				if (title == '首页') {
					return;
				}
				var tabs = index_tabs.tabs("tabs");
				if (tabs.length == 2) {
					var item = $('#index_tabsMenu').menu('findItem', '关闭其他');
					$('#index_tabsMenu').menu('disableItem', item.target);
				} else {
					var item = $('#index_tabsMenu').menu('findItem', '关闭其他');
					$('#index_tabsMenu').menu('enableItem', item.target);
				}
				e.preventDefault();
				index_tabsMenu.menu('show', {
					left : e.pageX,
					top : e.pageY
				}).data('tabTitle', title);
			}

		});
		index_tabsMenu = $('#index_tabsMenu').menu(
				{
					onClick : function(item) {
						var curTabTitle = $(this).data('tabTitle');
						var type = $(item.target).attr('title');
						if (type === 'close') {
							var t = index_tabs.tabs('getTab', curTabTitle);
							if (t.panel('options').closable) {
								index_tabs.tabs('close', curTabTitle);
							}
							return;
						}
						var allTabs = index_tabs.tabs('tabs');
						var closeTabsTitle = [];

						$.each(allTabs, function() {
							var opt = $(this).panel('options');
							if (opt.closable && opt.title != curTabTitle
									&& type === 'closeOther') {
								closeTabsTitle.push(opt.title);
							} else if (opt.closable && type === 'closeAll') {
								closeTabsTitle.push(opt.title);
							}
						});

						for (var i = 0; i < closeTabsTitle.length; i++) {
							index_tabs.tabs('close', closeTabsTitle[i]);
						}
					}
				});
		modifyPasswordDialog = $("#modifyPasswordDialog")
				.dialog(
						{
							title : '修改密码',
							width : 370,
							height : 240,
							closed : false,
							cache : false,
							modal : true,
							closed : true,
							buttons : [
									{
										text : '修改',
										iconCls : 'icon-save',
										handler : function() {
											if ($("#modifyPasswordForm").form(
													"validate")) {
												$
														.ajax({
															type : "POST",
															url : ctx
																	+ "/security/user!modifiedPassword.action",
															data : $(
																	"#modifyPasswordForm")
																	.serialize(),
															success : function(
																	data) {
																modifyPasswordDialog
																		.dialog("close");
																$.messager
																		.alert(
																				'成功',
																				'修改成功');
															}

														});
											}
										}
									},
									{
										text : '取消',
										iconCls : 'icon-cancel',
										handler : function() {
											modifyPasswordDialog
													.dialog("close");
										}
									} ]

						});
	});
	function zTreeOnClick(event, treeId, treeNode) {
		if (treeNode.url != "" && treeNode.url.length != 0) {
			addTab({
				cache : false,
				id : treeNode.id,
				title : treeNode.name,
				selected : true,
				closable : true,
				content : '<iframe src='
						+ treeNode.url
						+ ' width="100%" height="98%" scrolling="yes"  frameborder="0" style="border: 0px;width: 100%; height: 98%;"></iframe>'
			});
		} else {
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			treeObj.expandNode(treeNode);
		}
		event.preventDefault();
	};
	function addTab(ops) {
		
		if (index_tabs.tabs("existsById", ops.id)) {
			index_tabs.tabs("selectById", ops.id);
		} else {
			index_tabs.tabs("add", ops);

		} 
	}

	function logout() {
		location.href = ctx + "/security/user!logout.action";
	}
	function modifiedPasswordfn() {
		$
				.ajax({
					type : "GET",
					url : ctx
							+ "/security/user!getCurrentUserToModifyPassword.action",
					dataType : "json",
					success : function(data) {
						data = eval(data);
						$("#userId").val(data.id);
						//$("#oldPwd").val(data.userPwd);
						$("#pwd").val(data.userPwd);
						$('#modifyPasswordDialog input[name=oldPwd]')
								.validatebox(
										{
											required : true,
											title : "请输入您的原始密码",
											validType : 'validateOldPwd[\'#modifyPasswordForm input[id=pwd]\']'
										});
						$('#modifyPasswordDialog input[name=userPwd]')
								.validatebox({
									required : true,
									title : "请输入您的密码"
								});

						$('#modifyPasswordDialog input[name=rePwd]')
								.validatebox(
										{
											required : true,
											title : "请输入确认密码",
											validType : 'eqPwd[\'#modifyPasswordDialog input[name=password]\']'
										});

						$("#modifyPasswordDialog").dialog("open");
					}

				});
	}
</script>
<body class="easyui-layout">
	<div data-options="region:'north',split:true" style="height:70px;">
		<div class="panel-header panel-title"
			data-option="border:false,fit:true" style="height:63px;border: 0px;padding: 0px;">
			<img alt="logo" src="${ctx }/images/logo.gif" style="margin: 0px;">
			<div style="position: absolute; right: 10px; bottom: 2px;">
				<a href="javascript:void(0)" id="mb" class="easyui-menubutton"
					data-options="menu:'#mm'">${currentUser.realName }</a>
				<div id="mm" style="width: 150px;">
					<div onclick="modifiedPasswordfn()">修改密码</div>
					<div onclick="logout()">注销</div>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'west',title:'菜单管理',split:true"
		style="width: 150px; overflow: hidden;">
		<ul id="treeMenu" class="ztree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="index_tabs">
			<div title="首页" data-options="id:-1,border:false" cache="false">
				<iframe src="${ctx}/protal.jsp" frameborder="0"
					style="border: 0; width: 100%; height: 98%;"></iframe>
			</div>
		</div>
	</div>
</body>
<div id="index_tabsMenu" style="width: 120px; display: none;">
	<div id="closeCurrent" title="close" data-options="iconCls:'delete'">关闭</div>
	<div id="closeOther" title="closeOther" data-options="iconCls:'delete'">关闭其他</div>
	<div id="closeAll" title="closeAll" data-options="iconCls:'delete'">关闭所有</div>
</div>
<div id="modifyPasswordDialog">
	<form id="modifyPasswordForm"
		action="${ctx }/security/user!modifiedPassword.action" method="post"
		style="margin: 10px; font-size: 14px;">
		<table>
			<tr>
				<TD>原始密码： <input type="hidden" name="id" id="userId"><input
					type="hidden" id="pwd" name="pwd">
				</TD>
				<Td><input type="password" placeholder="请输入原始密码" id="oldPwd"
					name="oldPwd" /></Td>
			</tr>
			<tr>
				<TD>新密码：</TD>
				<Td><input type="password" name="password"
					class="field easyui-validatebox" data-options="required:true"
					placeholder="请输入您的新密码" /></Td>
			</tr>
			<tr>
				<TD>确认新密码：</TD>
				<Td><input type="password" name="rePwd"
					class="field easyui-validatebox"
					data-options="required:true,validType:'eqPwd[\'#modifyPasswordForm input[name=password]\']'"
					placeholder="请输入确认密码" /></Td>
			</tr>
		</table>
	</form>
</div>
</html>