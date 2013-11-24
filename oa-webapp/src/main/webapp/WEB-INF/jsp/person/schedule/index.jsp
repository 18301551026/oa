<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>我的日程</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
<%@include file="/common/include-jquery-easyui.jsp"%>	
<%@include file="/common/include-fullcalendar.jsp"%>
</head>
<body>
	<script>
		var  calendar;
		$(document).ready(function() {

			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();

			calendar=$('#calendar').fullCalendar({
				theme : true,
				header : {
					left : 'prev,next today',
					center : 'title',
					right : 'month,agendaWeek,agendaDay'
				},
				selectable: true,
				allDayText:'今天的任务',
				defaultView:'agendaWeek',
				 firstDay:1,
				 monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],  
		         monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],  
		         dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],  
		         dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],  
		         today: ["今天"],  
		         buttonText: {  
				      today: '今天',  
				      month: '月',  
				      week: '周',  
				      day: '日'  
		          },  
				editable : true,
				//事件点击
				eventClick:function(event, element){
					var url=ctx+"/person/schedule!toUpdate.action?id="+event.id;
					parent.$
					.modalDialog({
						title : "修改日程",
						width : 500,
						height : 360,
						href : url,
						buttons : [
								{
									text : '保存',
									iconCls : 'icon-save',
									handler : function() {
										parent.$.modalDialog.fullCalendar = calendar;
										var f = parent.$.modalDialog.handler
												.find('#editForm');
										f.submit(); 
									}
								},
								{
									text : '删除',
									iconCls : 'icon-remove',
									handler : function() {
										$.ajax({
											   type: "POST",
											   url: ctx+"/person/schedule!deleteSchedule.action",
											   data: "id="+event.id,
											   success: function(msg){
												   calendar.fullCalendar("removeEvents",event.id);
												   parent.$.modalDialog.handler.dialog('close');
												   $.messager.show({
														msg : '删除成功',
														title : '提示'
													});
											   }
											});
									}
								},
								
								{
									text : '取消',
									iconCls : 'icon-cancel',
									handler : function() {
										parent.$.modalDialog.handler
												.dialog('close');
									}
								} ]
					});
				},
				//选择
				select: function(start, end, allDay) {
					var tempStart = $.fullCalendar.formatDate(start,'yyyy-MM-dd HH:mm');
					var tempEnd = $.fullCalendar.formatDate(end,'yyyy-MM-dd HH:mm');
					var url=ctx+"/person/schedule!toAdd.action?strStartDate="+tempStart+"&strEndDate="+tempEnd+"&allDay="+allDay
					parent.$
					.modalDialog({
						title : "添加日程",
						width : 500,
						height : 360,
						href : url,
						buttons : [
								{
									text : '添加',
									iconCls : 'icon-save',
									handler : function() {
										parent.$.modalDialog.fullCalendar = calendar;
										var f = parent.$.modalDialog.handler
												.find('#editForm');
										f.submit(); 
									}
								},
								{
									text : '取消',
									iconCls : 'icon-cancel',
									handler : function() {
										parent.$.modalDialog.handler
												.dialog('close');
									}
								} ]
					});
				},
				eventDrop : function(event, delta,
						changeMinute, allDay,
						revertFunc, jsEvent, ui,
						view)  {
					var tempStart = $.fullCalendar.formatDate(event.start,'yyyy-MM-dd HH:mm');
					var tempEnd = $.fullCalendar.formatDate(event.end,'yyyy-MM-dd HH:mm');
					console.info("id="+event.id+"&strStartDate="+tempStart+"&strEndDate="+tempEnd+"&allDay="+event.allDay);
					$.ajax({
						   type: "POST",
						   url: ctx+"/person/schedule!dragSchedule.action",
						   data: "id="+event.id+"&strStartDate="+tempStart+"&strEndDate="+tempEnd+"&allDay="+event.allDay,
						   success: function(msg){
							   parent.$.messager.show({
									msg : '移动成功',
									title : '提示'
								});
						   }
						});
					
				},
			    eventResize: function(event,dayDelta,minuteDelta,revertFunc) {

			        alert(
			            "The end date of " + event.title + "has been moved " +
			            dayDelta + " days and " +
			            minuteDelta + " minutes."
			        );

			        if (!confirm("is this okay?")) {
			            revertFunc();
			        }

			    },
			    eventMouseover: function (calEvent, jsEvent, view) {
			    	var fstart = $.fullCalendar.formatDate(calEvent.start, "yyyy/MM/dd HH:mm");
			    	var fend = $.fullCalendar.formatDate(calEvent.end, "yyyy/MM/dd HH:mm");
				    	$(this).attr('title', fstart + " - " + fend + " <br/>" + "标题" + " : " + calEvent.title+"<br/>详情："+calEvent.content);
				    	$(this).css('font-weight', 'normal');
				    	$(this).tooltip({
				    		effect: 'toggle',
				    		cancelDefault: true
			    		});
			    },
				events : ctx+"/person/schedule!allSchedules.action"
			});

		});
	</script>
	<style>
body {
	margin-top: 20px;
	text-align: center;
	font-size: 13px;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}
.tooltip
    {
        padding-bottom: 25px;
        padding-left: 25px;
        padding-right: 25px;
        display: none;
        background: #999;
        height: 70px;
        color: red;
        font-size: 12px;
        padding-top: 25px;
        z-order: 10;
        text-align: left;
    }
#calendar {
	margin: 0 auto;
}
</style>
	<div id='calendar'></div>
</body>
</html>