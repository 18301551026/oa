package com.lxs.oa.work.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.lxs.process.domain.ActivitiBaseEntity;

@Entity
@Table(name = "leave_")
public class Leave extends ActivitiBaseEntity {
	private static final long serialVersionUID = -5801029648380496858L;
	
	private Integer days;
	private Date startDate;
	
	/**
	 * 查询条件 
	 */
	private Date endDate;

	@Column(name = "days_")
	public Integer getDays() {
		return days;
	}
	
	public void setDays(Integer days) {
		this.days = days;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "start_date_")
	public Date getStartDate() {
		return startDate;
	}
	
	@Transient
	public String getStartDateStr() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(startDate);
	}
	
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@Transient
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

}
