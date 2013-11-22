package com.lxs.oa.person.common;

public enum MailStatusEnum {

	sendBox(1), // 发件箱
	receiveBox(2), // 收件箱
	draftBox(3), // 草稿箱
	noRead(4), // 未读
	readed(5);// 已读
	private Integer value;

	private MailStatusEnum(Integer value) {
		this.value = value;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}