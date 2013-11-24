var selectedUsers = document.getElementById('selectedUsers');
var receivedUserNames = document.getElementById('receiveUsersName');
var ids = document.getElementById('ids');
$(function() {
	var seleceUserByDept = document.getElementById('seleceUserByDept');
	var allUsers = document.getElementById('allUsers');
	var allDept = document.getElementById('allDept');
	$("#selectedUsers").dblclick(function() {
		for ( var i = selectedUsers.options.length - 1; i >= 0; i--) {
			if (selectedUsers.options[i].selected) {
				selectedUsers.remove(i);
				/* console.info(selectedUsers.options[i].value); */
				var values = getValue(selectedUsers);
				ids.value = values.substr(0, values.length - 1);
				var texts = getText(selectedUsers);
				receivedUserNames.value = texts.substr(0, texts.length - 1);
				console.info(ids.value);
			}
		}
	});
	$("#seleceUserByDept").dblclick(function() {
		moveOptions(seleceUserByDept, selectedUsers);
	})
	$("#allUsers").dblclick(function() {
		moveOptions(allUsers, selectedUsers);
	})
	$("#allDept").dblclick(function() {
		moveOptions(allDept, selectedUsers);
	})

	$(".searchbox-button").live('click', function() {
		var name = $("#searchuserbox").searchbox("getValue");
		$.ajax({
			type : "post",
			url : ctx + "/security/user!findUserByName.action",
			data : "realName=" + name,
			success : function(html) {
				document.getElementById("allUsers").innerHTML = html;
			}
		});
	})

})
function moveOptions(e1, e2) {
	for ( var i = e1.options.length - 1; i >= 0; i--) {
		if (e1.options[i].selected) {
			var e = e1.options[i];
			var flag = false;
			for ( var j = e2.options.length - 1; j >= 0; j--) {
				var ee = e2.options[j];
				if (ee.value == e.value) {
					flag = true;
				}
			}
			if (!flag) {
				e2.options.add(new Option(e.text, e.value), e2.options.length);

			}

		}
	}
	var value = getValue(selectedUsers);
	var text = getText(selectedUsers);
	ids.value = value.substr(0, value.length - 1);
	receivedUserNames.value = text.substr(0, text.length - 1);
}
function getValue(list) {
	if (!list) {
		return '';
	}
	var value = "";
	for ( var i = 0; i < list.options.length; i++) {
		value += list.options[i].value + ",";
	}
	if (value.length < 1) {
		return '';
	} else {
		return value;
	}

}
function getText(list) {
	if (!list) {
		return '';
	}
	var text = "";
	for ( var i = 0; i < list.options.length; i++) {
		text = text + list.options[i].text + ",";
	}
	if (text.length < 1) {
		return '';
	} else {
		return text;
	}

}
function selectDeptToShowUserfn() {
	var seleceUserByDept = document.getElementById('seleceUserByDept');
	var id = $("#selectDeptToShowUser").val();
	$.ajax({
		type : "POST",
		url : ctx + "/person/sendBox!findUserByDept.action",
		data : "deptId=" + id,
		success : function(html) {
			document.getElementById("seleceUserByDept").innerHTML = html;
		}

	});
}