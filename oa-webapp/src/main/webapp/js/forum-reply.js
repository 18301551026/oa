$(function() {
	$(".deleteReplyBtn").click(function() {
				if (window.confirm('确认删除')) {
					location.href = $(this).attr("actionUrl");
				}
			});
	$(".editReplyBtn").click(function() {
		var id = $(this).attr("replyId");
		var inp = "<input type='hidden' name='id' value=" + id + " />";
		var title = $(this).parent().prev().html();
		var con = $(this).parent().parent().next().children().children()[1].innerHTML;
		$("#title").val(title);
		editor1.html(con);
		$("#editForm").append(inp);
		$("#replyFont").html('编辑')
		location.href = '#targetPlace';
		$("#title").focus();

	});
	$(".refReplyBtn").click(function() {
		var inp = $("#editForm :input[type=hidden][name=id]");
		if (inp) {
			inp.remove();
		}
		var title = $(this).parent().prev().html();
		var con = $(this).parent().parent().next().children().children()[1].innerHTML;
		$("#title").val(title);
		editor1.html(con);
		$("#replyFont").html('回帖')
		location.href = '#targetPlace';
		$("#title").focus();
	});
	$(".replyReplyBtn").click(function() {
				var inp = $("#editForm :input[type=hidden][name=id]");
				if (inp) {
					inp.remove();
				}
				var replyUserName = $(this).attr("replyUserName");
				$("#title").val("回复" + replyUserName);
				$("#replyFont").html('回帖')
				location.href = '#targetPlace';
				$("#title").focus();
			});
});