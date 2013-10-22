package com.lxs.process.common;

public enum JobEnum {

	deptManager("部门主管");
	
	private JobEnum(String value) {
		this.value = value;
	}
	
	private String value;

	public String getValue() {
		return value;
	}
	
}
