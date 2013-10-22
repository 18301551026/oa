package com.lxs.oa.common;

public enum AddressTypeEnum {
	
	person("个人通讯录"), company("公司通讯录");
	
	private String value;
	
	private AddressTypeEnum(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
	
}
