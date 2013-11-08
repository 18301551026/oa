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
import com.lxs.core.cache.ClearCache;
import com.lxs.security.domain.Resource;
import com.lxs.security.domain.Role;
import com.lxs.security.domain.User;
import com.lxs.security.service.IRoleService;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value = "role", className = "roleAction")
@Results({
		@Result(name = "add", location = "/WEB-INF/jsp/security/role/add.jsp"),
		@Result(name = "update", location = "/WEB-INF/jsp/security/role/update.jsp"),
		@Result(name = "list", location = "/WEB-INF/jsp/security/role/list.jsp"),
		@Result(name = "listAction", type = "redirect", location = "/security/role!findPage.action"),
		@Result(name = "updateAction", type = "redirect", location = "/security/role!toUpdate.action?id=${id}"),
		@Result(name = "toAssignMenu", location = "/WEB-INF/jsp/security/role/assignMenu.jsp") })
public class RoleAction extends BaseAction<Role> {

	@javax.annotation.Resource
	private IRoleService roleService;

	private Long userId;
	private Long resourceId;

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}

	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getRoleName() && !"".equals(model.getRoleName())) {
			criteria.add(Restrictions.like("roleName", model.getRoleName(),
					MatchMode.ANYWHERE));
		}
	}

	@Override
	public void afterToUpdate(Role role) {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		List<Resource> resources = baseService.find(DetachedCriteria
				.forClass(Resource.class));
		Set<User> roleUsers = role.getUsers();
		Set<Resource> roleResources = role.getResources();

		for (User user : roleUsers) {
			users.remove(user);
		}
		for (Resource resource : roleResources) {
			resources.remove(resource);
		}

		ActionContext.getContext().put("userList", users);
		ActionContext.getContext().put("resourceList", resources);
	}

	/**
	 * 为角色添加用户
	 * 
	 * @return
	 */
	public String addUser() {
		roleService.addUser(userId, model.getId());

		return UPDATE_ACTION;
	}

	/**
	 * 为角色删除用户
	 * 
	 * @return
	 */
	public String deleteUser() {
		roleService.deleteUser(userId, model.getId());

		return UPDATE_ACTION;
	}

	/**
	 * 为角色添加资源
	 * 
	 * @return
	 */
	public String addResource() {
		roleService.addResource(resourceId, model.getId());

		return UPDATE_ACTION;
	}

	/**
	 * 为角色删除资源
	 * 
	 * @return
	 */
	public String deleteResource() {
		roleService.deleteResource(resourceId, model.getId());

		return UPDATE_ACTION;
	}

	/**
	 * 为角色分配菜单
	 */
	public void assignMenu() {
		roleService.doAssignMenu2Role(model.getId(), ids);

		getOut().println("{success: true}");
	}

	public String toAssignMenu() {
		// ActionContext.getContext().getValueStack()
		// .push(baseService.get(modelClass, model.getId()));
		return "toAssignMenu";
	}
}
