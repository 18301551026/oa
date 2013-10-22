package com.lxs.security.action;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

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
import com.lxs.core.common.SystemConstant;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.Job;
import com.lxs.security.domain.Role;
import com.lxs.security.domain.User;
import com.lxs.security.service.IUserService;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value="user", className="userAction")
@Results({
	@Result(name="add", location="/WEB-INF/jsp/security/user/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/security/user/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/security/user/list.jsp"),
	@Result(name="listAction", type="redirect", location="/security/user!findPage.action"),
	@Result(name="updateAction", type="redirect", location="/security/user!toUpdate.action?id=${id}"),
	@Result(name="index", type="redirect", location="/index.jsp"),
	@Result(name="login", type="redirect", location="/login.jsp")
	
})
public class UserAction extends BaseAction<User> {

	@Resource
	private IUserService userService;
	
	private Long roleId;
	private Long deptId;
	private Long jobId;
	
	
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getUserName() && !"".equals(model.getUserName())) {
			criteria.add(Restrictions.like("userName", model.getUserName(),
					MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void afterToUpdate(User user) {
		List<Role> roles = baseService.find(DetachedCriteria.forClass(Role.class));
		Set<Role> userRoles = user.getRoles();
		for (Role role : userRoles) {
			roles.remove(role);
		}
		ActionContext.getContext().put("roleList", roles);
		
		List<Dept> depts = baseService.find(DetachedCriteria.forClass(Dept.class));
		Set<Dept> userDepts = user.getDepts();
		for (Dept dept : userDepts) {
			depts.remove(dept);
		}
		ActionContext.getContext().put("deptList", depts);
		
		List<Job> jobs = baseService.find(DetachedCriteria.forClass(Job.class));
		Set<Job> userJobs = user.getJobs();
		for (Job job : userJobs) {
			jobs.remove(job);
		}
		ActionContext.getContext().put("jobList", jobs);
	}
	
	public String addRole() {
		userService.addRole(roleId, model.getId());
		
		return UPDATE_ACTION;
	}
	
	@ClearCache
	public String deleteRole() {
		userService.deleteRole(roleId, model.getId());
		
		return UPDATE_ACTION;
	}	
	
	public String addDept() {
		userService.addDept(deptId, model.getId());
		
		return UPDATE_ACTION;
	}
	
	public String deleteDept() {
		userService.deleteDept(deptId, model.getId());
		
		return UPDATE_ACTION;
	}
	
	public String addJob() {
		userService.addJob(jobId, model.getId());
		
		return UPDATE_ACTION;
	}
	
	public String deleteJob() {
		userService.deleteJob(jobId, model.getId());
		
		return UPDATE_ACTION;
	}		
	
	/**
	 * 登陆
	 * @return
	 */
	public String login() {
		User user = userService.login(model.getUserName(), model.getPassword());
		if (null != user) {
			ActionContext.getContext().getSession().put(SystemConstant.CURRENT_USER, user);
			return INDEX;
		} else {
			return LOGIN;
		}
	}
	
	/** 
	 * 注销
	 * @return
	 */
	public String logout() {
		ActionContext.getContext().getSession().remove(SystemConstant.CURRENT_USER);
		return LOGIN;
	}
	
	
	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}

}