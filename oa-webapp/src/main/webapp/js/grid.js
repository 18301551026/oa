$(function() {
	$("#addButton").click(function() {
		window.location.href = $(this).attr("actionUrl");
	});
	$("#deleteButton").click(
			function() {
				if ($("input[name='ids']:checked")
						&& $("input[name='ids']:checked").length > 0) {
					if (window.confirm('确认删除')) {
						$("#deleteForm").submit();
					}
				} else {
					alert('请选择删除的记录');
				}
			});

	$("#checkAllCheckBox").click(function() {
		if ($(this).attr("checked")) {
			$(":checkbox[name='ids']").attr("checked", true);
		} else {
			$(":checkbox[name='ids']").attr("checked", false);
		}

	});
	$('#queryButton').click(function() {
		$("#queryForm").submit();
	});

	$("#startButton").click(
			function() {
				if ($("input[name='ids']:checked")
						&& $("input[name='ids']:checked").length > 0) {
					$('#deleteForm').attr('action', $(this).attr("actionUrl"));
					$('#deleteForm').submit();
				} else {
					alert('请选择要启动的记录');
				}

			});

	$("#showOrHideQueryPanelBtn")
			.click(
					function() {
						$("#queryPanel").toggleClass("hide");
						if ($("#queryPanel").hasClass("hide")) {
							$(this)
									.html(
											'<span class="glyphicon glyphicon-chevron-down pull-right"></span> 查询条件');
						} else {
							$(this)
									.html(
											'<span class="glyphicon glyphicon-chevron-up pull-right"></span> 查询条件');
						}
					});
	$("#sendButton").click(
			function() {
				if ($("input[name='ids']:checked")
						&& $("input[name='ids']:checked").length > 0) {
					var url = $(this).attr("actionUrl");
					$("#deleteForm").attr("action", url);
					$("#deleteForm").submit();
				} else {
					alert('请选择发送的邮件');
				}

			})
});