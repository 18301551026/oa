package com.lxs.oa.message.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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
import javax.persistence.Table;
import javax.persistence.Transient;

import com.lxs.security.domain.User;

@Entity
@Table(name = "share_file_")
public class ShareFile implements Serializable {
	private Long id;
	private String fileName;
	private User ownerUser;
	private Date uploadDate;
	private byte[] content;
	private String size;
	private Set<User> users = new HashSet<User>();
	private ShareFileTree fileTree;

	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "file_name_")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id_")
	public User getOwnerUser() {
		return ownerUser;
	}

	public void setOwnerUser(User ownerUser) {
		this.ownerUser = ownerUser;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "file_user_", joinColumns = { @JoinColumn(name = "file_id_") }, inverseJoinColumns = { @JoinColumn(name = "user_id_") })
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "file_tree_id_")
	public ShareFileTree getFileTree() {
		return fileTree;
	}

	public void setFileTree(ShareFileTree fileTree) {
		this.fileTree = fileTree;
	}

	@Column(name = "upload_date_")
	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	@Lob
	@Column(name = "content_")
	public byte[] getContent() {
		return content;
	}

	public void setContent(byte[] content) {
		this.content = content;
	}

	@Column(name = "size_")
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	private Integer status;
	@Transient
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
