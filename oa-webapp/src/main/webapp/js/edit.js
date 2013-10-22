
$(function() {
	$("#saveButton").click(function(){
		$("#editForm").submit();
	});
	
	$("#resetButton").click(function(){
		$("#editForm").reset();
	});
	
	$("#backButton").click(function(){
		history.go(-1);
	});
	
});
