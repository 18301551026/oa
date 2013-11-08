<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="com.lxs.core.common.page.PageResult"
	required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">
	var queryForm;
	$(function() {
		var url = window.location.href;
		var path = url.substr(url.indexOf(ctx));

		//判断查询form是否存在  		
		$('form').each(function() {
			var r = new RegExp($(this).attr('action'));
			if (r.test(path)) {
				queryForm = $(this);
			}
		});

		//如果不存在queryForm
		if (!queryForm) {
			$(document.body).append(
					'<form id = "queryForm" method="post"></form>');
			queryForm = $('#queryForm');
			queryForm.attr('action', window.location.href);
		}

		//在form中添加start,pageSize对象
		queryForm.append('<s:hidden name="start" id="start"></s:hidden>');
		queryForm.append('<s:hidden name="pageSize" id="pageSize"></s:hidden>');

		//初始化分页变量
		var start = parseInt($('#start').val());
		var pageSize = parseInt($('#pageSize').val());
		//总页数
		var pageCount = parseInt($('#pageCount').html());

		//判断边界
		if (start == 0) {
			$('#prev').toggleClass("disabled");
			$('#first').toggleClass("disabled");
		}
		if (start == (pageCount - 1) * pageSize || pageCount == 0) {
			$('#next').toggleClass("disabled");
			$('#last').toggleClass("disabled");
		}

		//分页按钮事件
		$('#first').bind('click', function() {
			if ($(this).attr("class") !== "disabled") {
				$("#start").val(0);
				queryForm.submit();
			}
		});
		$('#next').bind('click', function() {
			if ($(this).attr("class") !== "disabled") {
				$('#start').val(start + pageSize);
				queryForm.submit();
			}
		});
		$('#prev').bind('click', function() {
			if ($(this).attr("class") !== "disabled") {
				$('#start').val(start - pageSize);
				queryForm.submit();
			}

		});
		$('#last').bind('click', function() {
			if ($(this).attr("class") !== "disabled") {
				$('#start').val((pageCount - 1) * pageSize);
				queryForm.submit();
			}
		});
		//设置每页行数下拉列表框的onchange事件
		$('#setPageSize').bind('change', function() {
			$('#pageSize').val($('#setPageSize').val());
			$('#start').val(0);
			queryForm.submit();
		});
		$(".gotoPageNo").click(function() {
			var p = parseInt($(this).html());
			$('#start').val((p - 1) * pageSize);
			queryForm.submit();
		});

	});
</script>

<c:set var="m" value="${page.rowCount % pageSize}"></c:set>
<c:set var="pageCountDouble"
	value="${m == 0 ? page.rowCount/pageSize : (page.rowCount - m)/pageSize + 1}"></c:set>
<fmt:formatNumber pattern="#" value="${pageCountDouble }"
	var="pageCount"></fmt:formatNumber>
<c:set var="pageNo" value="${start / pageSize + 1}"></c:set>
<c:set var="begin" value="${1 > pageNo-5 ? 1 : pageNo-5 }"></c:set>
<c:set var="end"
	value="${pageNo + 5 < pageCount ? pageNo + 5 : pageCount}"></c:set>

<div class="pagination pull-right">
	<ul class="pagination-sm">
		<li class="disabled"><a>共<span id="rowCount">${page.rowCount}</span>行<span
				id="pageCount">${pageCount }</span>页
		</a></li>
		<li id="first"><a href="javascript:void(0)">首页</a></li>
		<li id="prev"><a href="javascript:void(0)">上一页</a></li>

		<c:forEach var="i" begin="${begin }" end="${end}">
			<c:choose>
				<c:when test="${i == pageNo}">
					<li class="active"><a href="javascript:void(0)">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:void(0)" class="gotoPageNo">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<li id="next"><a href="javascript:void(0)">下一页</a></li>
		<li id="last"><a href="javascript:void(0)">末页</a></li>
		<li><a> <s:select
					list="#{10:'10行', 20:'20行', 30:'30行', 40: '40行', 50: '50行' }"
					id="setPageSize" name="pageSize" cssStyle="width:80px; margin:0px;">
				</s:select>
		</a></li>
	</ul>

</div>
<div class="clearfix"></div>
<div style="height: 40px;"></div>