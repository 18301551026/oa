package com.lxs.oa.work.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.lxs.security.domain.User;

@Entity
@Table(name = "vote_option_")
public class VoteOption implements Serializable {
	private Long id;
	private VoteSubject subject;
	private String optionName;
	private Set<User> users = new HashSet<User>();
	// 所获票数
	private Integer nums;

	@Id
	@GeneratedValue
	@Column(name = "id")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "subject_id_")
	public VoteSubject getSubject() {
		return subject;
	}

	public void setSubject(VoteSubject subject) {
		this.subject = subject;
	}

	@Column(name = "option_name_")
	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "option_user_", joinColumns = { @JoinColumn(name = "option_id_") }, inverseJoinColumns = { @JoinColumn(name = "user_id_") })
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}
	
	private Integer percent;
	@Transient
	public Integer getPercent() {
		return percent;
	}

	public void setPercent(Integer percent) {
		this.percent = percent;
	}
	@Column(name="nums_")
	public Integer getNums() {
		return nums;
	}

	public void setNums(Integer nums) {
		this.nums = nums;
	}
}
