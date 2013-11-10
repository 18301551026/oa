<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/global.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@include file="/common/include-jquery-easyui.jsp"%>
<%@include file="/common/include-protal.jsp"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>门户页面</title>
</head>
<body>
	<script type="text/javascript" charset="utf-8">
		var portalLayout;
		var portal;
		$(function() {

			portalLayout = $('#portalLayout').layout({
				fit : true
			});
			$(window).resize(function() {
				portalLayout.layout('panel', 'center').panel('resize', {
					width : 1,
					height : 1
				});
			});

			panels = [
					{
						id : 'p1',
						title : '新闻',
						height : 200,
						collapsible : true,
						content :'这是新闻',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p1").panel('expand').panel('refresh');
							}
						} ]
					},
					{
						id : 'p2',
						title : '短消息',
						height : 200,
						collapsible : true,
						content :'这是短消息',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p2").panel('expand').panel('refresh');
							}
						} ]
					},
					{
						id : 'p3',
						title : '公告',
						height : 200,
						collapsible : true,
						content :'这是公告',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p3").panel('expand').panel('refresh');
							}
						} ]
					},
					{
						id : 'p4',
						title : '事务',
						height : 200,
						collapsible : true,
						content :'这是事务',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p4").panel('expand').panel('refresh');
							}
						} ]
					},
					{
						id : 'p5',
						title : '日程安排',
						height : 200,
						collapsible : true,
						content :'这是日程安排',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p5").panel('expand').panel('refresh');
							}
						} ]
					}, {
						id : 'p6',
						title : '工作计划',
						height : 200,
						collapsible : true,
						content :'这是工作计划',
						tools : [ {
							iconCls : 'icon-reload',
							handler : function() {
								$("#p6").panel('expand').panel('refresh');
							}
						} ]
					} ];

			portal = $('#portal').portal({
				border : false,
				fit : true,
				onStateChange : function() {
					$.cookie('portal-state', getPortalState(), {
						expires : 7
					});
				}
			});
			var state = $.cookie('portal-state');
			if (!state) {
				state = 'p1,p2,p3:p4,p5,p6';/*冒号代表列，逗号代表行*/
			}
			addPortalPanels(state);
			portal.portal('resize');

		});

		function getPanelOptions(id) {
			for (var i = 0; i < panels.length; i++) {
				if (panels[i].id == id) {
					return panels[i];
				}
			}
			return undefined;
		}
		function getPortalState() {
			var aa = [];
			for (var columnIndex = 0; columnIndex < 2; columnIndex++) {
				var cc = [];
				var panels = portal.portal('getPanels', columnIndex);
				for (var i = 0; i < panels.length; i++) {
					cc.push(panels[i].attr('id'));
				}
				aa.push(cc.join(','));
			}
			return aa.join(':');
		}
		function addPortalPanels(portalState) {
			var columns = portalState.split(':');
			for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
				var cc = columns[columnIndex].split(',');
				for (var j = 0; j < cc.length; j++) {
					var options = getPanelOptions(cc[j]);
					if (options) {
						var p = $('<div/>').attr('id', options.id).appendTo(
								'body');
						p.panel(options);
						portal.portal('add', {
							panel : p,
							columnIndex : columnIndex
						});
					}
				}
			}
		}
	</script>
	<div id="portalLayout">
		<div data-options="region:'center',border:false">
			<div id="portal" style="position: relative">
				<div></div>
				<div></div>
			</div>
		</div>
	</div>
</body>
</html>