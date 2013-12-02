<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/common/meta.jsp"%>
<title>门户页面</title>
<%@include file="/common/global.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@include file="/common/include-jquery-easyui.jsp"%>
<%@include file="/common/include-portal.jsp"%>

</head>
<body>
	<style type="text/css">
.fillet {
	border-radius: 10px;
	border: 1px solid #D1E2F0;
	background: none repeat scroll 0 0 #E0ECFF;
	width: 97%;
	height: 93%;
	margin: 5px;
	overflow: hidden;
}

.fillet table {
	width: 98%;
	height: 98%;
	border-collapse: collapse;
	border: none;
}

.fillet .index_table td {
	border-bottom: 1px solid #95B8E7;
}

.fillet .index_table tr {
	height: 20%;
	font-size: 12px;
}

.l {
	float: left;
}

.r {
	float: right;
}
</style>
	<script type="text/javascript" src="${ctx }/js/portal.js"></script>
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