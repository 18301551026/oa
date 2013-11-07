$(function() {
	$("#addButton").click(function() {
				window.location.href = $(this).attr("actionUrl");
			});
	$("#deleteButton").click(function() {
				if ($("input:checked") && $("input:checked").length > 0) {
					if (window.confirm('确认删除')) {
						$("#deleteForm").submit();
					}
				} else {
					alert('请选择删除的记录');
				}
			});
	$('#queryButton').click(function() {
				$("#queryForm").submit();
			});
	
	$("#startButton").click(function() {
				$('#deleteForm').attr('action', $(this).attr("actionUrl"));
				$('#deleteForm').submit();
			});

	$("#showOrHideQueryPanelBtn").click(function() {
		$("#queryPanel").toggleClass("hide");
		if ($("#queryPanel").hasClass("hide")) {
			$(this)
					.html('<span class="glyphicon glyphicon-chevron-down pull-right"></span>');
		} else {
			$(this)
					.html('<span class="glyphicon glyphicon-chevron-up pull-right"></span>');
		}
	});
});