<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/global.jsp"%>
<title>投票</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-jquery.jsp"%>
<%@ include file="/common/include-jquery-easyui.jsp"%>
</head>
<body>
	<script type="text/javascript" src="${ctx }/js/person-vote.js">
		
	</script>
	<form action="" method="post" id="voteForm">
		<div align="center" style="margin-top: 10px;">
			<ul
				style="list-style: none; padding: 0px; margin-top: 6px; width: 85%; height: 80%;">
				<li style="text-align: right;">发布人：<s:property
						value="owner.realName" />&nbsp;发布日期：<s:property value="startDate" />
				</li>
				<li
					style="border-bottom: 1px solid #95B8E7; margin-bottom: 12px; background-color: #E0ECFF; font-size: 15px; text-align: left; line-height: 30px;">
					<s:property value="title" />
				</li>
				<s:iterator value="options">
					<li
						style="border-bottom: 1px solid #95B8E7; margin-bottom: 12px; text-align: left;">
						<label style="width: 5%;"> <input
							<s:if test="voteType.id==1">
								type="radio"
							</s:if>
							<s:if test="voteType.id==2">
								type="checkbox"
							</s:if>
							name="ids" value="${id }" />
					</label> <label style="width: 85%">${optionName }</label>
					</li>
				</s:iterator>
				<li
					style="border-bottom: 1px solid #95B8E7; margin-bottom: 12px; background-color: #E0ECFF; font-size: 15px; text-align: left; line-height: 30px;">
					<div>
						说明：
						<s:property value="desc" />
					</div>
				</li>
			</ul>
		</div>
	</form>
</body>
</html>