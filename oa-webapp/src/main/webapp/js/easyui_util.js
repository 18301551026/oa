(function($) {
	/**
	 * 使panel和datagrid在加载时提示
	 * 
	 * @author 孙宇
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 */
	$.fn.panel.defaults.loadingMessage = '加载中....';
	$.fn.datagrid.defaults.loadMsg = '加载中....';

	/**
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
	 */
	$.fn.panel.defaults.onBeforeDestroy = function() {
		var frame = $('iframe', this);
		try {
			if (frame.length > 0) {
				for (var i = 0; i < frame.length; i++) {
					frame[i].src = '';
					frame[i].contentWindow.document.write('');
					frame[i].contentWindow.close();
				}
				frame.remove();
				if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
					try {
						CollectGarbage();
					} catch (e) {
					}
				}
			}
		} catch (e) {
		}
	};

	/**
	 * 
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 * 防止panel/window/dialog组件超出浏览器边界
	 * @param left
	 * @param top
	 */
	var easyuiPanelOnMove = function(left, top) {
		var l = left;
		var t = top;
		if (l < 1) {
			l = 1;
		}
		if (t < 1) {
			t = 1;
		}
		var width = parseInt($(this).parent().css('width')) + 14;
		var height = parseInt($(this).parent().css('height')) + 14;
		var right = l + width;
		var buttom = t + height;
		var browserWidth = $(window).width();
		var browserHeight = $(window).height();
		if (right > browserWidth) {
			l = browserWidth - width;
		}
		if (buttom > browserHeight) {
			t = browserHeight - height;
		}
		$(this).parent().css({/* 修正面板位置 */
			left : l,
			top : t
		});
	};
	$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
	$.fn.window.defaults.onMove = easyuiPanelOnMove;
	$.fn.panel.defaults.onMove = easyuiPanelOnMove;

	/**
	 * 
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 * 创建一个模式化的dialog
	 * 
	 * @returns $.modalDialog.handler 这个handler代表弹出的dialog句柄
	 * 
	 * @returns $.modalDialog.xxx 这个xxx是可以自己定义名称，主要用在弹窗关闭时，刷新某些对象的操作，可以将xxx这个对象预定义好
	 */
	$.modalDialog = function(options) {
		if ($.modalDialog.handler == undefined) {// 避免重复弹出
			var opts = $.extend({
				title : '',
				width : 840,
				height : 680,
				modal : true,
				onClose : function() {
					$.modalDialog.handler = undefined;
					$(this).dialog('destroy');
				},
				onOpen : function() {
					/*
					 * parent.$.messager.progress({ title : '提示', text :
					 * '数据处理中，请稍后....' });
					 */
				}
			}, options);
			opts.modal = true;// 强制此dialog为模式化，无视传递过来的modal参数
			return $.modalDialog.handler = $('<div/>').dialog(opts);
		}
	};

	$.cookie = function(key, value, options) {
		if (arguments.length > 1 && (value === null || typeof value !== "object")) {
			options = $.extend({}, options);
			if (value === null) {
				options.expires = -1;
			}
			if (typeof options.expires === 'number') {
				var days = options.expires, t = options.expires = new Date();
				t.setDate(t.getDate() + days);
			}
			return (document.cookie = [
					encodeURIComponent(key),
					'=',
					options.raw ? String(value) : encodeURIComponent(String(value)),
					options.expires ? '; expires=' + options.expires.toUTCString()
							: '', options.path ? '; path=' + options.path : '',
					options.domain ? '; domain=' + options.domain : '',
					options.secure ? '; secure' : '' ].join(''));
		}
		options = value || {};
		var result, decode = options.raw ? function(s) {
			return s;
		} : decodeURIComponent;
		return (result = new RegExp('(?:^|; )' + encodeURIComponent(key)
				+ '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
	};

	/**
	 * 
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 * 扩展treegrid，使其支持平滑数据格式
	 */
	$.fn.treegrid.defaults.loadFilter = function(data, parentId) {
		var opt = $(this).data().treegrid.options;
		var idFiled, textFiled, parentField;
		if (opt.parentField) {
			idFiled = opt.idFiled || 'id';
			textFiled = opt.textFiled || 'text';
			parentField = opt.parentField;
			var i, l, treeData = [], tmpMap = [];
			for (i = 0, l = data.length; i < l; i++) {
				tmpMap[data[i][idFiled]] = data[i];
			}
			for (i = 0, l = data.length; i < l; i++) {
				if (tmpMap[data[i][parentField]]
						&& data[i][idFiled] != data[i][parentField]) {
					if (!tmpMap[data[i][parentField]]['children'])
						tmpMap[data[i][parentField]]['children'] = [];
					data[i]['text'] = data[i][textFiled];
					tmpMap[data[i][parentField]]['children'].push(data[i]);
				} else {
					data[i]['text'] = data[i][textFiled];
					treeData.push(data[i]);
				}
			}
			return treeData;
		}
		return data;
	};

	/**
	 * 扩展validatebox，添加数字验证功能
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		number : {
			validator : function(value, param) {
				var num = new RegExp(/^\d+$/);
				return num.test(value);
			},
			message : '必须为非负整数'
		}
	});
	/**
	 * 
	 * 
	 * @requires jQuery,EasyUI
	 * 
	 * 扩展validatebox，添加验证两次密码功能
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		eqPwd : {
			validator : function(value, param) {
				return value == $(param[0]).val();
			},
			message : '两次输入的密码不一致！'
		}
	});
	/**
	 * 扩展validatebox，修改密码是输入原始密码判断
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		validateOldPwd : {
			validator : function(value, param) {
				if (value != $(param[0]).val()) {
					return false;
				} else {
					return true;
				}
			},
			message : '原始密码输入错误'
		}
	});
	
	/**
	 * 通过id属性获得tabpanel中对应的panel
	 */
	function getTabById(container, which, removeit) {
		var tabs = $.data(container, 'tabs').tabs;
		if (typeof which == 'number') {
			for (var i = 0; i < tabs.length; i++) {
				var tab = tabs[i];
				if (tab.panel('options').id == which) {
					if (removeit) {
						tabs.splice(i, 1);
					}
					return tab;
				}
			}

		}
		return null;
	}
	
	/**
	 * 通过id选中tabpanel中的panel
	 */
	function selectTab(container, which) {
		var opts = $.data(container, 'tabs').options;
		var tabs = $.data(container, 'tabs').tabs;
		var selectHis = $.data(container, 'tabs').selectHis;

		if (tabs.length == 0)
			return;

		var panel = getTabById(container, which); // get the panel to be
													// activated
		if (!panel)
			return;

		var selected = getSelectedTab(container);
		if (selected) {
			selected.panel('close');
			selected.panel('options').tab.removeClass('tabs-selected');
		}

		panel.panel('open');
		var title = panel.panel('options').title; // the panel title
		selectHis.push(title); // push select history

		var tab = panel.panel('options').tab; // get the tab object
		tab.addClass('tabs-selected');

		// scroll the tab to center position if required.
		var wrap = $(container).find('>div.tabs-header>div.tabs-wrap');
		var left = tab.position().left;
		var right = left + tab.outerWidth();
		if (left < 0 || right > wrap.width()) {
			var deltaX = left - (wrap.width() - tab.width()) / 2;
			$(container).tabs('scrollBy', deltaX);
		} else {
			$(container).tabs('scrollBy', 0);
		}

		setSelectedSize(container);

		opts.onSelect.call(container, title, getTabIndex(container, panel));
	}
	
	/**
	 * 设置tabpanel中panel的size,用于根据id判断panel是否在tabpanel中存在
	 */
	function setSelectedSize(container) {
		var opts = $.data(container, 'tabs').options;
		var tab = getSelectedTab(container);
		if (tab) {
			var panels = $(container).children('div.tabs-panels');
			var width = opts.width == 'auto' ? 'auto' : panels.width();
			var height = opts.height == 'auto' ? 'auto' : panels.height();
			tab.panel('resize', {
				width : width,
				height : height
			});
		}
	}
	/**
	 * 用于根据id判断panel是否在tabpanel中存在,私有方法
	 */
	function getSelectedTab(container) {
		var tabs = $.data(container, 'tabs').tabs;
		for (var i = 0; i < tabs.length; i++) {
			var tab = tabs[i];
			if (tab.panel('options').closed == false) {
				return tab;
			}
		}
		return null;
	}
	/**
	 * 设置tabpanel中panel的size,用于根据id判断panel是否在tabpanel中存在
	 */
	function getTabIndex(container, tab) {
		var tabs = $.data(container, 'tabs').tabs;
		for (var i = 0; i < tabs.length; i++) {
			if (tabs[i][0] == $(tab)[0]) {
				return i;
			}
		}
		return -1;
	}
	
	/**
	 * 扩展tabpanel，增加根据id判断是否存在,和根据id选择的方法
	 */
	$.extend($.fn.tabs.methods, {
		/**
		 * 根据id是否存在
		 */
		existsById : function(jq, which) {
			return getTabById(jq[0], which) != null;
		},
		/**
		 * 根据id选中panel
		 */
		selectById : function(jq, which) {
			return jq.each(function() {
				selectTab(this, which);
			});
		}
	});
})(jQuery);