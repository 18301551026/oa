$(function() {
	$("#addButton").click(function(){
		window.location.href = $(this).attr("actionUrl");
	});
	$("#deleteButton").click(function(){
		if ($("input:checked") && $("input:checked").length > 0) {
			if (window.confirm('确认删除')) {
				$("#deleteForm").submit();	
			}
		} else {
			alert('请选择删除的记录');
		} 
	});
	$('#queryButton').click(function(){
		$("#queryForm").submit();
	});
	$("#checkAllCheckBox").click(function(){
		if ($("#checkAllCheckBox").attr("checked")) {
			$(":checkbox[name='ids']").attr("checked", true);	
		} else {
			$(":checkbox[name='ids']").attr("checked", false);	
		}
	});
	$("#startButton").click(function(){
		$('#deleteForm').attr('action', $(this).attr("actionUrl"));
		$('#deleteForm').submit();		
	});
});