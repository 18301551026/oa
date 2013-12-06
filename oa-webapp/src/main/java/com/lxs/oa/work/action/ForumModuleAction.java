package com.lxs.oa.work.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

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
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.person.domain.ForumSubject;
import com.lxs.oa.work.domain.Module;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/work")
@Action("module")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/work/forum/list.jsp"),
		@Result(name = "add", location = "/WEB-INF/jsp/work/forum/add.jsp"),
		@Result(name = "update", location = "/WEB-INF/jsp/work/forum/update.jsp"),
		@Result(name = "listAction", location = "/work/module!findPage.action", type = "redirect"),
		@Result(name = "toSelectCanWatchUsers", location = "/WEB-INF/jsp/work/forum/selectCanWatchUsers.jsp") })
public class ForumModuleAction extends BaseAction<Module> {
	private String canWatchUserIds;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		criteria.createAlias("user", "u");
		criteria.add(Restrictions.eq("u.id", u.getId()));
		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
	}

	@Override
	public void beforeDelete(Module m) {
		model.setCanWatchUsers(null);
		Iterator<ForumSubject> iterator = m.getSubjects().iterator();
		while (iterator.hasNext()) {
			ForumSubject s = iterator.next();
			baseService.delete(s);
		}
		m.setSubjects(null);
	}

	@Override
	public void beforeSave(Module model) {
		model.setCreateDate(new Date());
		model.setUser((User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER));
	}

	@Override
	public void afterSave(Module mo) {
		mo.setCanWatchUsers(null);
		baseService.save(mo);
		addCanWatchUser(mo);
	}

	@Override
	public void afterToUpdate(Module m) {
		List<User> users = m.getCanWatchUsers();
		canWatchUserIds = "";
		for (User user : users) {
			canWatchUserIds += user.getId() + ",";
		}
		canWatchUserIds = canWatchUserIds.substring(0,
				canWatchUserIds.length() - 1);
	}

	public String toSelectCanWatchUsers() {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		ActionContext.getContext().put("allUsers", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);
		if (null != model.getId()) {
			Module m = baseService.get(Module.class, model.getId());
			ActionContext.getContext().getValueStack().push(m);
			List<User> hadUsers = m.getCanWatchUsers();
			ActionContext.getContext().put("hadUsers", hadUsers);
			canWatchUserIds = "";
			for (User user : hadUsers) {
				canWatchUserIds += user.getId() + ",";
			}
			canWatchUserIds = canWatchUserIds.substring(0,
					canWatchUserIds.length() - 1);
		}
		return "toSelectCanWatchUsers";
	}

	public void addCanWatchUser(Module mo) {
		List<User> executeUsers = new ArrayList<User>();
		String userIds[] = canWatchUserIds.split(",");
		if (null != userIds) {
			for (String string : userIds) {
				// 全体人员
				if (string.trim().equals("0")) {
					DetachedCriteria detachedCriteria = DetachedCriteria
							.forClass(User.class);
					executeUsers = baseService.find(detachedCriteria);
					break;
				}
				// 部门人员
				if (string.trim().indexOf("d") != -1) {
					Long deptId = Long.parseLong(string.trim().substring(1));
					DetachedCriteria detachedCriteria = DetachedCriteria
							.forClass(User.class);
					detachedCriteria.createAlias("depts", "d");
					detachedCriteria.add(Restrictions.eq("d.id", deptId));
					List<User> users = baseService.find(detachedCriteria);

					for (User user : users) {
						if (!executeUsers.contains(user)) {
							executeUsers.add(user);
						}
					}
					continue;
				}
				Long userId = Long.parseLong(string.trim());
				DetachedCriteria detachedCriteria = DetachedCriteria
						.forClass(User.class);
				detachedCriteria.add(Restrictions.eq("id", userId));
				List<User> users = baseService.find(detachedCriteria);
				for (User user : users) {
					if (!executeUsers.contains(user)) {
						executeUsers.add(user);
					}
				}
			}
		}

		mo.setCanWatchUsers(executeUsers);
		baseService.save(mo);
	}

	public String getCanWatchUserIds() {
		return canWatchUserIds;
	}

	public void setCanWatchUserIds(String canWatchUserIds) {
		this.canWatchUserIds = canWatchUserIds;
	}
}
