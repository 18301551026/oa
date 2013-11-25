$(function() {
	$("#addAttach")
			.click(
					function() {
						var temp = $(this)
								.before(
										'<input type="file" class="pull-left" name="attach" /><input class="btn btn-info btn-xs pull-left deleteAttach" value="删除" type="button" />');
					})
})