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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.lxs.security.domain.User;

@Entity
@Table(name = "vote_option_")
public class VoteOption implements Serializable {
	private Long id;
	private VoteSubject subject;
	private String optionName;
	private Set<User> uses = new HashSet<User>();

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
	@JoinTable(name = "option_subject_", joinColumns = { @JoinColumn(name = "option_id_") }, inverseJoinColumns = { @JoinColumn(name = "subject_id_") })
	public Set<User> getUses() {
		return uses;
	}

	public void setUses(Set<User> uses) {
		this.uses = uses;
	}
}
