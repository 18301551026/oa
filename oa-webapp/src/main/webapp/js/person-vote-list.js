$(function() {
		$(".showVoteResultButton").click(function() {
			var voteId = $(this).attr("voteId");
			$.ajax({
				type : "POST",
				url : ctx + "/person/vote!checkVoted.action",
				data : "id=" + voteId,
				success : function(msg) {
					var obj = jQuery.parseJSON(msg);
					if (obj.success) {
						toShowDetailFn(voteId);
					} else {
						alert("请先投票后再查看结果");
					}
				}
			});

		})
		$(".toVoteButton").click(function() {
			var voteId = $(this).attr("voteId");
			$.ajax({
				type : "POST",
				url : ctx + "/person/vote!checkVoted.action",
				data : "id=" + voteId,
				success : function(msg) {
					var obj = jQuery.parseJSON(msg);
					if (obj.success) {
						alert("您已经投过票了");
					} else {
						toVoteFn(voteId);
					}
				}
			});
		})

	})
	function toShowDetailFn(voteId) {
		parent.$.modalDialog({
			title : "投票详情",
			width : 650,
			height : 400,
			href : ctx+"/person/vote!toShowVoteDetail.action?id="+voteId,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-cancel',
				handler : function() {
					parent.$.modalDialog.handler.dialog('close');
				}
			} ]
		});
	}
	function toVoteFn(voteId) {
		parent.$.modalDialog({
			title : "请投票",
			width : 600,
			height : 400,
			href : ctx + "/person/vote!toVote.action?id=" + voteId,
			buttons : [ {
				text : '投票',
				iconCls : 'icon-save',
				handler : function() {
					var f = parent.$.modalDialog.handler.find('#voteForm');
					f.submit();
				}
			}, {
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					parent.$.modalDialog.handler.dialog('close');
				}
			} ]
		});
	}