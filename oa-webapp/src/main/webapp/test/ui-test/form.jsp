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
	<div style="margin:10px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="loadLocal()">LoadLocal</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="loadRemote()">LoadRemote</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">Clear</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open') ">Open</a>
	</div>
	
	<div class="easyui-dialog" id="dlg" data-options="closed: false" title="New Topic" style="width:400px" >
		<div style="padding:10px 0 10px 60px">
	    <form id="ff" method="post">
	    	<table>
	    		<tr>
	    			<td>Name:</td>
	    			<td><input class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>Email:</td>
	    			<td><input class="easyui-validatebox" type="text" name="email" data-options="required:true,validType:'email'"></input></td>
	    		</tr>
	    	</table>
	    </form>
	    </div>
	    
	<div style="margin:10px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doSubmit()">submit</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" >reset</a>
	</div>	    
	</div>
	<script>
		function loadLocal(){
			$('#ff').form('load',{
				name:'myname',
				email:'mymail@gmail.com',
			});
		}
		function loadRemote() {
			$.get("load.jsp", function(d){
				$("#ff").form('load', eval("("+d+")"));
			})
		}
		function doSubmit() {
			//表单ajax提交
			$('#ff').form({  
				//提交地址
			    url: 'doSubmit.jsp',
			    //在提交之前执行，执行验证等。。。
			    onSubmit: function(){  
			    	alert('doSubmit')
			    },  
			    
			    //当有结果返回执行
			    success:function(data){  
			        alert(data)  
			    }  
			});  
			// 提交表单
			$('#ff').submit();
			/*
			$('#ff').form('submit', {  
			    url:'doSubmit.jsp',  
			    onSubmit: function(){  
			        // do some check  
			        // return false to prevent submit;  
			    },  
			    success:function(data){  
			        alert(data)  
			    }  
			});*/ 
		}
	</script>
</body>
</html>