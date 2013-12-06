package com.lxs.oa.work.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lxs.oa.person.domain.ForumSubject;
import com.lxs.security.domain.User;

/**
 * 论坛模块
 * 
 */
@Entity
@Table(name = "module_")
public class Module implements Serializable {
	private Long id;
	private String title;
	private String desc;
	private Date createDate;
	private User user;
	private List<User> canWatchUsers = new ArrayList<User>();
	private String canWathUserNames;
	private Set<ForumSubject> subjects = new HashSet<ForumSubject>();

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
	@Column(name = "desc_")
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "create_date_")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id_")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "module_user_", joinColumns = { @JoinColumn(name = "module_id_") }, inverseJoinColumns = { @JoinColumn(name = "user_id_") })
	public List<User> getCanWatchUsers() {
		return canWatchUsers;
	}

	public void setCanWatchUsers(List<User> canWatchUsers) {
		this.canWatchUsers = canWatchUsers;
	}

	@Column(name = "can_watch_user_names_")
	public String getCanWathUserNames() {
		return canWathUserNames;
	}

	public void setCanWathUserNames(String canWathUserNames) {
		this.canWathUserNames = canWathUserNames;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "module", cascade = CascadeType.REMOVE)
	public Set<ForumSubject> getSubjects() {
		return subjects;
	}

	public void setSubjects(Set<ForumSubject> subjects) {
		this.subjects = subjects;
	}

}
