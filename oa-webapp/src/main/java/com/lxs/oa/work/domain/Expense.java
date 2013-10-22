package com.lxs.oa.work.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.lxs.process.domain.ActivitiBaseEntity;

@Entity
@Table(name = "expense_")
public class Expense extends ActivitiBaseEntity {
	private static final long serialVersionUID = -5801029648380496858L;
	
	private Double money;
	
	/**
	 * 查询条件 
	 */
	private Double startMoney;
	private Double endMoney;

	@Column(name = "money_")
	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	@Transient
	public Double getStartMoney() {
		return startMoney;
	}

	public void setStartMoney(Double startMoney) {
		this.startMoney = startMoney;
	}

	@Transient
	public Double getEndMoney() {
		return endMoney;
	}

	public void setEndMoney(Double endMoney) {
		this.endMoney = endMoney;
	}

}
