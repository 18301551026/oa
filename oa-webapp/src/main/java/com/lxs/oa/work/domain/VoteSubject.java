package com.lxs.oa.work.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
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
import javax.persistence.Transient;

import com.lxs.security.domain.User;

@Entity
@Table(name = "vote_subject_")
public class VoteSubject implements Serializable {
	private Long id;
	private String title;
	private User owner;// 发布人
	private Set<VoteOption> options = new HashSet<VoteOption>();// 选项
	private Set<User> users = new HashSet<User>();// 投票范围
	private VoteType voteType; // 投票类型
	private String desc; // 描述
	private Date startDate; // 开始时间
	private Date endDate; // 结束时间
	private Integer status; // 状态
	private String canVoteUsersName;
	private boolean anonymous;//是否匿名

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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id_")
	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "subject",cascade=CascadeType.REMOVE)
	public Set<VoteOption> getOptions() {
		return options;
	}

	public void setOptions(Set<VoteOption> options) {
		this.options = options;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "vote_subject_user_", joinColumns = { @JoinColumn(name = "subject_id_") }, inverseJoinColumns = { @JoinColumn(name = "user_id_") })
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "type_id_")
	public VoteType getVoteType() {
		return voteType;
	}

	public void setVoteType(VoteType voteType) {
		this.voteType = voteType;
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
	@Column(name = "start_date_")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "end_date_")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "status_")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	@Column(name="can_vote_users_name_")
	public String getCanVoteUsersName() {
		return canVoteUsersName;
	}

	public void setCanVoteUsersName(String canVoteUsersName) {
		this.canVoteUsersName = canVoteUsersName;
	}
	@Column(name="anonymous_")
	public boolean isAnonymous() {
		return anonymous;
	}

	public void setAnonymous(boolean anonymous) {
		this.anonymous = anonymous;
	}
	
	private Integer hadUserVoteNum;
	@Transient
	public Integer getHadUserVoteNum() {
		return hadUserVoteNum;
	}

	public void setHadUserVoteNum(Integer hadUserVoteNum) {
		this.hadUserVoteNum = hadUserVoteNum;
	}
}
