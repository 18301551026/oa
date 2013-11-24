$(function() {
	$("#addAttach")
			.click(
					function() {
						var temp = $(this)
								.before(
										'<s:file name="attach" cssClass="pull-left"></s:file><input class="btn btn-info btn-xs pull-left deleteAttach" value="删除" type="button" />');
					})
})