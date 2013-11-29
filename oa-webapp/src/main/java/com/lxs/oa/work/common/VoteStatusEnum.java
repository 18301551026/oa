package com.lxs.oa.work.common;

public enum VoteStatusEnum {
	notPublish(1),//未发布
	published(2),//已发布
	end(3);//已终止
	private Integer value;
	private VoteStatusEnum(Integer value){
		this.value=value;
	}
	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}
