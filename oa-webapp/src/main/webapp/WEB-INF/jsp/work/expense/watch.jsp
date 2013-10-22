<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
	<title>查看报销单</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-styles.jsp" %>
	<script type="text/javascript" src="${ctx}/js/jquery-${jqueryVersion}.min.js"></script>
	<%@ include file="/common/include-jquery-kindeditor.jsp" %>
    <script type="text/javascript" src="${ctx }/js/edit2Editor.js"></script>
</head>

<body>

	<div id="navigatorDiv">
	  	<button type="button" id="backButton" class="button positive">
    		<img src="${ctx}/js/easyui/themes/icons/undo.png" alt=""/> 返回
  	  	</button>
	</div>
	
	<div id="editDiv">
		<fieldset>
		<legend><small>报销单查看</small></legend>
		<table >
		  <tbody>
			<tr>				
				<td width="20%"><label>报销金额：</label></td>
				<td>
					<s:textfield name="money" readonly="true"></s:textfield>
				</td>
			</tr>
			<tr>				
				<td width="20%"><label>报销原因：</label></td>
				<td>
					<div class="show-html">${reason }</div>
				</td>
			</tr>
			  <!-- 审批意见 -->
			  <c:forEach items="${commentList}" var="c">
			  <tr>
				<td>${c.taskName }</td>
				<td style="color: blue;">
					${c.comment }
				</td>
			  </tr>	  
			  </c:forEach>
		  </tbody>
		</table>
		</fieldset>
	</div>

</body>
</html>
