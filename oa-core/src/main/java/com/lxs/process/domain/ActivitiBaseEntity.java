package com.lxs.process.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import com.lxs.security.domain.User;

/**
 * MappedSuperclass：注解可以被继承
 * 
 */
@MappedSuperclass
public class ActivitiBaseEntity implements Serializable {
	
	private Long id;
	private String title;
	private String reason;
	private Integer status;
	private User user;
	
	/**
	 * 查询条件，如果不为空，查询所有用户的请假单
	 */
	private String queryByAllUser;
	
	
	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "title_")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Lob
	@Column(name = "reason_")
	public String getReason() {
		return reason;
	}
	
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@Column(name = "status_")
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id_")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	@Transient
	public String getQueryByAllUser() {
		return queryByAllUser;
	}

	public void setQueryByAllUser(String queryByAllUser) {
		this.queryByAllUser = queryByAllUser;
	}

}
