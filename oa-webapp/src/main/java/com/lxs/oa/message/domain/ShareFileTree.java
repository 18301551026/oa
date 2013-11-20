package com.lxs.oa.message.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "share_file_tree_")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer" })
public class ShareFileTree implements Serializable {
	private Long id;
	private String text;
	private String url;
	private ShareFileTree parent;
	private List<ShareFileTree> children = new ArrayList<ShareFileTree>();
	@JsonIgnore
	private Set<ShareFile> files = new HashSet<ShareFile>();

	@Id
	@Column(name = "id_")
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "text_")
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Column(name = "url_")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pid_")
	public ShareFileTree getParent() {
		return parent;
	}

	public void setParent(ShareFileTree parent) {
		this.parent = parent;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	public List<ShareFileTree> getChildren() {
		return children;
	}

	public void setChildren(List<ShareFileTree> children) {
		this.children = children;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "fileTree")
	public Set<ShareFile> getFiles() {
		return files;
	}

	public void setFiles(Set<ShareFile> files) {
		this.files = files;
	}

	private String state;

	@Transient
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}
