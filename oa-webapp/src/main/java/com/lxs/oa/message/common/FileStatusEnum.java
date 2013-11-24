package com.lxs.oa.message.common;

public enum FileStatusEnum {

	upload(1), // 上传
	download(2); // 下载
	private Integer value;

	private FileStatusEnum(Integer value) {
		this.value = value;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}