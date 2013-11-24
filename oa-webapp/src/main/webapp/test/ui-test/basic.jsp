<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
    <title>部门管理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
    <%@ include file="/common/include-jquery.jsp"%>
    <%@ include file="/common/include-jquery-easyui.jsp" %>
</head>


<body>
	<h2>Basic Dialog</h2>
	<div class="demo-info">
		<div class="demo-tip icon-tip"></div>
		<div>Click below button to open or close dialog.</div>
	</div>
	<div style="margin:10px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')">Open</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">Close</a>
	</div>
	<hr>
	
	<!-- 
		class="easyui-dialog":指定easy-ui所使用的样式
		data-options：指定控件属性
			iconCls：图标
			resizable：是否可改变大小
			model：模态窗口
			closed：默认关闭
		$('#dlg').dialog('open')：打开dialog
		$('#dlg').dialog('close')：关闭dialog
	-->
	<div id="dlg" class="easyui-dialog" title="My Dialog" style="width:400px;height:200px;"    
	        data-options="iconCls:'icon-save',resizable:false,modal:true, closed: true">    
	    Dialog Content.    
	</div>   
</body>
</html>