package com.lxs.oa.person.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="attachment_")
public class Attachment implements Serializable {
	private Long id;
	private Mail mail;
	private String attachmentName;
	private String content;
	@Id
	@Column(name="id_")
	@GeneratedValue
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="mail_id_")
	public Mail getMail() {
		return mail;
	}
	public void setMail(Mail mail) {
		this.mail = mail;
	}
	@Column(name="attachment_name_")
	public String getAttachmentName() {
		return attachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}
	@Lob
	@Column(name="content_")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
