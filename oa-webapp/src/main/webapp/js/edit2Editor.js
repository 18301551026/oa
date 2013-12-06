var editor2;
var editor1 ;
$(function() {
	editor1= KindEditor
			.create(
					'textarea[name="content"],textarea[name="desc"],textarea[name="reason"]',
					{
						uploadJson : ctx + '/kindeditor/upload_json.jsp',
						fileManagerJson : ctx
								+ '/kindeditor/file_manager_json.jsp',
						width : '100%',
						allowFileManager : true
					});
	editor2 = KindEditor.create('textarea[name="comment"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		width : '100%',
		items : [ 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor',
				'bold', 'italic', 'underline', 'removeformat', '|',
				'justifyleft', 'justifycenter', 'justifyright',
				'insertorderedlist', 'insertunorderedlist', '|', 'emoticons',
				'image', 'link' ]
	});

	$("#saveButton").click(function() {
		if (editor1) {
			editor1.sync();
		}
		if (editor2) {
			editor2.sync();
		}
		$("#editForm").submit();
	});
	$("#backButton").click(function() {
		history.go(-1);
	});
	$("#resetButton").click(function() {
		var url = $(this).attr("actionUrl");
		if (url) {
			location.href = url;
		} else {
			if (editor1) {
				editor1.html("");
			}
			if (editor2) {
				editor2.html("");
			}
			/* $("#editForm").reset(); */
			$("#editForm :input").val('');
		}
	});

	$("#backButton").click(function() {
		history.go(-1);
	});
	$("#otherButton").click(function() {
		if (editor1) {
			editor1.sync();
		}
		if (editor2) {
			editor2.sync();
		}
		var url = $(this).attr("actionUrl");
		$("#editForm").attr("action", url);
		$("#editForm").submit();
	})
	$("#turnToOther").click(function() {
		var url = $(this).attr("actionUrl");
		location.href = url;
	})
	$("#sendButton").click(function() {
		if (editor1) {
			editor1.sync();
		}
		if (editor2) {
			editor2.sync();
		}
		var url = $(this).attr("actionUrl");
		$("#editForm").attr("action", url);
		$("#editForm").submit();
	});

	$(".deleteAttach").live("click", function() {
		var pre = $(this).prev();
		pre.remove();
		$(this).remove();
	})
	$(".deleteOption").live("click", function() {
		var url = $(this).attr("deleteAction");
		var id = $(this).attr("deleteId");
		if (url) {
			$.ajax({
				type : "POST",
				url : url,
				data : "optionId=" + id,
				success : function(msg) {

				}
			});
		}
		var pre = $(this).prev();
		pre.remove();
		var after=$(this).next().next(":input[value='修改']");
		if(after){
			$(after[0]).remove();
		}
		$(this).remove();
	})
	jQuery("#editForm").validationEngine();

});
