<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>我的日程</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>	
<%@include file="/common/include-fullcalendar.jsp"%>
</head>
<body>
<script type="text/javascript" src="${ctx }/js/schedule-index.js"></script>

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