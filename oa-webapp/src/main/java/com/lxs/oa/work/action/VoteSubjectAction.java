package com.lxs.oa.work.action;

import java.util.ArrayList;
import java.util.HashSet;
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
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.person.common.MailStatusEnum;
import com.lxs.oa.person.domain.Mail;
import com.lxs.oa.person.domain.MailUser;
import com.lxs.oa.work.domain.VoteOption;
import com.lxs.oa.work.domain.VoteSubject;
import com.lxs.oa.work.domain.VoteType;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/work")
@Action("voteSubject")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/work/vote/list.jsp"),
		@Result(name = "listAction", location = "/work/voteSubject!findPage.action", type = "redirect"),
		@Result(name = "toSelectVoteArea", location = "/WEB-INF/jsp/work/vote/selectCanVoteUsers.jsp"),
		@Result(name = "add", location = "/WEB-INF/jsp/work/vote/add.jsp") })
public class VoteSubjectAction extends BaseAction<VoteSubject> {
	private String voteOptions[];
	private String canVoteIds;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		criteria.createAlias("owner", "u");
		criteria.add(Restrictions.eq("u.id", u.getId()));
	}

	public String toSelectVoteArea() {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		ActionContext.getContext().put("users", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);
		return "toSelectVoteArea";
	}

	@Override
	public void beforeSave(VoteSubject model) {

		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setOwner(u);
	}

	@Override
	public void afterSave(VoteSubject m) {
		Set<VoteOption> options = new HashSet<VoteOption>();
		// 保存选项
		for (String str : voteOptions) {
			if (null != str && str.trim().length() != 0) {
				VoteOption op = new VoteOption();
				op.setOptionName(str);
				op.setSubject(m);
				baseService.add(op);
				options.add(op);
			}
		}
		m.setOptions(options);
		// 添加之后添加可投票人
		addCanVoteUser(m);
	}

	public void addCanVoteUser(VoteSubject sub) {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		List<User> executeUsers = new ArrayList<User>();
		String userIds[] = canVoteIds.split(",");
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
		Set<User> tempSet = new HashSet<User>();
		for (User user : executeUsers) {
			tempSet.add(user);
		}
		sub.setUsers(tempSet);
		baseService.save(sub);
	}

	@Override
	public void beforToAdd() {
		List<VoteType> types = baseService.find(DetachedCriteria
				.forClass(VoteType.class));
		ActionContext.getContext().put("types", types);
	}

	public String[] getVoteOptions() {
		return voteOptions;
	}

	public void setVoteOptions(String[] voteOptions) {
		this.voteOptions = voteOptions;
	}

	public String getCanVoteIds() {
		return canVoteIds;
	}

	public void setCanVoteIds(String canVoteIds) {
		this.canVoteIds = canVoteIds;
	}
}
