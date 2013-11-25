package com.lxs.oa.work.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * 投票类型：单选和多选等
 * 
 */
@Entity
@Table(name = "vote_type_")
public class VoteType implements Serializable {
	private Long id;
	private String typeName;
	private Set<VoteSubject> subjects = new HashSet<VoteSubject>();

	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "type_name_")
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "voteType")
	public Set<VoteSubject> getSubjects() {
		return subjects;
	}

	public void setSubjects(Set<VoteSubject> subjects) {
		this.subjects = subjects;
	}

}
