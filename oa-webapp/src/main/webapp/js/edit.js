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
	jQuery("#editForm").validationEngine();
});
