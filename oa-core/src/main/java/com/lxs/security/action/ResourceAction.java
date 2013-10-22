package com.lxs.security.action;


import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.BaseAction;
import com.lxs.security.domain.Resource;
import com.lxs.security.domain.Role;
import com.lxs.security.service.IResourceService;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value="resource", className="resourceAction")
@Results({
	@Result(name="add", location="/WEB-INF/jsp/security/resource/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/security/resource/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/security/resource/list.jsp"),
	@Result(name="listAction", type="redirect", location="/security/resource!findPage.action"),
	@Result(name="updateAction", type="redirect", location="/security/resource!toUpdate.action?id=${id}")
})
public class ResourceAction extends BaseAction<Resource> {

	/**
	 * 为资源添加的角色的ID
	 */
	private Long roleId;
	
	@javax.annotation.Resource
	private IResourceService resourceService;
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getUrl() && !"".equals(model.getUrl())) {
			criteria.add(Restrictions.like("url", model.getUrl(), MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void afterToUpdate(Resource resource) {
		//所有角色
		List<Role> roles = baseService.find(DetachedCriteria.forClass(Role.class));
		//资源已有的角色
		Set<Role> resourceRoles = resource.getRoles();
		//把所有的角色去掉以有的角色，得到资源没有的角色
		for (Role role : resourceRoles) {
			roles.remove(role);
		}
		ActionContext.getContext().put("roleList", roles);
	}
	
	/**
	 * 为资源添加角色
	 * @return
	 */
	public String addRole() {
		resourceService.addRole(roleId, model.getId());
		
		return UPDATE_ACTION;
	}
	
	/**
	 * 为资源删除角色
	 * @return
	 */
	public String deleteRole() {
		resourceService.deleteRole(roleId, model.getId());
		
		return UPDATE_ACTION;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}	
	
}
