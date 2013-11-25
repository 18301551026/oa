$(function() {
	$("#addOption")
			.click(
					function() {
						var temp = $(this)
								.after(
										'<s:textfield name="voteOptions" cssClass="form-control validate[required] pull-left" placeholder="请输入投票选项"  cssStyle="width:95%"  ></s:textfield><input class="btn btn-info btn-xs pull-right deleteOption" value="删除" type="button" />');
					})
})
