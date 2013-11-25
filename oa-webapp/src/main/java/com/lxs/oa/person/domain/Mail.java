package com.lxs.oa.person.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.lxs.security.domain.User;

@Entity
@Table(name = "mail_")
public class Mail implements Serializable {
	private Long id;
	private String title;
	private String content;
	private User sendUser;// 发件箱
	private String sendUserName;
	private String receiveUsersName;
	private String createDate;
	private Integer status;// 状态 0：草稿箱中，1：已发送
	private Set<MailUser> mailUsers = new HashSet<MailUser>();// 收件和收件的中间表
	private Set<Attachment> attachments = new HashSet<Attachment>();// 附件

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "mail")
	public Set<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(Set<Attachment> attachments) {
		this.attachments = attachments;
	}

	@Id
	@Column(name = "id_")
	@GeneratedValue
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
	@Column(name = "content_")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id_")
	public User getSendUser() {
		return sendUser;
	}

	public void setSendUser(User sendUser) {
		this.sendUser = sendUser;
	}

	@Column(name = "send_user_name_")
	public String getSendUserName() {
		return sendUserName;
	}

	public void setSendUserName(String sendUserName) {
		this.sendUserName = sendUserName;
	}

	@Column(name = "receive_users_name")
	public String getReceiveUsersName() {
		return receiveUsersName;
	}

	public void setReceiveUsersName(String receiveUsersName) {
		this.receiveUsersName = receiveUsersName;
	}

	@Column(name = "status_")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "mail")
	public Set<MailUser> getMailUsers() {
		return mailUsers;
	}

	public void setMailUsers(Set<MailUser> mailUsers) {
		this.mailUsers = mailUsers;
	}

	private Integer mailStatus;

	@Transient
	public Integer getMailStatus() {
		return mailStatus;
	}

	public void setMailStatus(Integer mailStatus) {
		this.mailStatus = mailStatus;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

}
