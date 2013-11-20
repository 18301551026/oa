$(function() {
	$("#saveButton").click(function() {
		$("#editForm").submit();
	});
	$("#resetButton").click(function() {
		var url = $(this).attr("actionUrl");
		if (url) {
			location.href = url;
		} else {

			/* $("#editForm").reset(); */
			$("#editForm :input").val('');
		}

	});
	$("#backButton").click(function() {
		history.go(-1);
	});

	$("#otherButton").click(function() {
		var url = $(this).attr("actionUrl");
		$("#editForm").attr("action", url);
		$("#editForm").submit();
	})
	$("#turnToOther").click(function() {
		var url = $(this).attr("actionUrl");
		location.href = url;
	})
	jQuery("#editForm").validationEngine();
});
