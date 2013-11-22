package com.lxs.security.domain;

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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.annotation.JSONType;

@Entity
@Table(name = "menu_")
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)

@JSONType(ignores = "hibernateLazyInitializer")
public class Menu implements Serializable {
	
	private Long id;
	private String name;
	private String url;
	private Integer order;
	private String target;
	private Boolean open;
	private String icon;
	
	private boolean checked;
	
	private Menu parent;
	private List<Menu> children = new ArrayList<Menu>();
	
	private Set<Role> roles = new HashSet<Role>();
	
	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "url_")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "name_")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	} 	

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id_")
	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}
	
	/**
	 * OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	 * 
	 * @return
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	@OrderBy("order")
	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "menus")
	@JSONField(serialize = false)
	public Set<Role> getRoles() {
		return roles;
	}

	@JSONField(deserialize = false)
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Column(name = "target_")
	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	@Column(name = "order_")
	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	@Column(name = "icon_")
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(name = "open_")
	public Boolean getOpen() {
		return open;
	}

	public void setOpen(Boolean open) {
		this.open = open;
	}

	@Transient
	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	private String text;//显示名称
	private Long pid;//父节点Id
	private String state;//状态：此节点是否打开
	@Transient
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	@Transient
	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}
	@Transient
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
