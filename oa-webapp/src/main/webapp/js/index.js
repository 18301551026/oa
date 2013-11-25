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
	$.post(ctx + '/security/menu!findMenuByUser.action', function(data) {
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

					for ( var i = 0; i < closeTabsTitle.length; i++) {
						index_tabs.tabs('close', closeTabsTitle[i]);
					}
				}
			});
	modifyPasswordDialog = $("#modifyPasswordDialog").dialog({
		title : '修改密码',
		width : 370,
		height : 240,
		closed : false,
		cache : false,
		modal : true,
		closed : true,
		buttons : [ {
			text : '修改',
			iconCls : 'icon-save',
			handler : function() {
				if ($("#modifyPasswordForm").form("validate")) {
					$.ajax({
						type : "POST",
						url : ctx + "/security/user!modifiedPassword.action",
						data : $("#modifyPasswordForm").serialize(),
						success : function(data) {
							modifyPasswordDialog.dialog("close");
							$.messager.alert('成功', '修改成功');
						}

					});
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				modifyPasswordDialog.dialog("close");
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
					// $("#oldPwd").val(data.userPwd);
					$("#pwd").val(data.userPwd);
					$('#modifyPasswordDialog input[name=oldPwd]')
							.validatebox(
									{
										required : true,
										title : "请输入您的原始密码",
										validType : 'validateOldPwd[\'#modifyPasswordForm input[id=pwd]\']'
									});
					$('#modifyPasswordDialog input[name=userPwd]').validatebox(
							{
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