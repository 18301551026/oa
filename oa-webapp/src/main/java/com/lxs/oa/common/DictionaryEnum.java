package com.lxs.oa.common;

public enum DictionaryEnum {
	
	news("新闻类型"), notice("通知类型"), rule("制度类型");
	
	private String value;
	
	private DictionaryEnum(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

}
