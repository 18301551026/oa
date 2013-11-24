<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>OA协同办公系统</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-ztree.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<script type="text/javascript">
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
	});
	function zTreeOnClick(event, treeId, treeNode) {
		if (treeNode.url != "" && treeNode.url.length != 0) {
			addTab({
				cache : false,
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
		if (index_tabs.tabs("exists", ops.title)) {
			index_tabs.tabs("select", ops.title);
		} else {
			index_tabs.tabs("add", ops);

		}
	}
</script>
<body class="easyui-layout">
	<div data-options="region:'west',title:'菜单管理',split:true"
		style="width: 150px; overflow: hidden;">
		<ul id="treeMenu" class="ztree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="index_tabs">
			<div title="首页" data-options="border:false">这是首页</div>
		</div>
	</div>
</body>
<div id="index_tabsMenu" style="width: 120px; display: none;">
	<div id="closeCurrent" title="close" data-options="iconCls:'delete'">关闭</div>
	<div id="closeOther" title="closeOther" data-options="iconCls:'delete'">关闭其他</div>
	<div id="closeAll" title="closeAll" data-options="iconCls:'delete'">关闭所有</div>
</div>
</html>