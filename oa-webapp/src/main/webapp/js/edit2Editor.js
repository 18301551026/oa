var editor2;
$(function() {
	var editor1 = KindEditor.create(
			'textarea[name="content"],textarea[name="reason"]', {
				uploadJson : ctx + '/kindeditor/upload_json.jsp',
				fileManagerJson : ctx + '/kindeditor/file_manager_json.jsp',
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

	jQuery("#editForm").validationEngine();

});
