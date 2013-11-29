package com.lxs.oa.work.action;

import java.util.ArrayList;
import java.util.Date;
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
import com.lxs.oa.work.common.VoteStatusEnum;
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
		@Result(name = "update", location = "/WEB-INF/jsp/work/vote/update.jsp"),
		@Result(name = "add", location = "/WEB-INF/jsp/work/vote/add.jsp") })
public class VoteSubjectAction extends BaseAction<VoteSubject> {
	private String voteOptions[];
	private String canVoteIds;
	private Long optionId;
	private String optionText;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		// 每次查询之前都会自动搜索已经到期的投票将之设为已终止
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(VoteSubject.class);
		detachedCriteria.add(Restrictions.eq("status",
				VoteStatusEnum.published.getValue()));
		detachedCriteria.add(Restrictions.le("endDate", new Date()));
		List<VoteSubject> endSubjects = baseService.find(detachedCriteria);
		if (null != endSubjects && endSubjects.size() != 0) {
			for (VoteSubject endSubject : endSubjects) {
				endSubject.setStatus(VoteStatusEnum.end.getValue());
				baseService.save(endSubject);
			}
		}

		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		criteria.createAlias("owner", "u");
		criteria.add(Restrictions.eq("u.id", u.getId()));
	}

	@Override
	public void beforeDelete(VoteSubject m) {
		for (VoteOption o : m.getOptions()) {
			baseService.delete(o);
		}
		m.setOptions(null);
		baseService.save(m);
	}

	public String toSelectVoteArea() {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		ActionContext.getContext().put("allUsers", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);
		if (null != model.getId()) {
			VoteSubject s = baseService.get(VoteSubject.class, model.getId());
			ActionContext.getContext().getValueStack().push(s);
			Set<User> hadUsers = s.getUsers();
			ActionContext.getContext().put("hadUsers", hadUsers);
			canVoteIds = "";
			for (User user : hadUsers) {
				canVoteIds += user.getId() + ",";
			}
			canVoteIds = canVoteIds.substring(0, canVoteIds.length() - 1);
		}
		return "toSelectVoteArea";
	}

	/**
	 * 重新启动
	 * 
	 * @return
	 */
	public String startVote() {
		model = baseService.get(VoteSubject.class, model.getId());
		model.setStatus(VoteStatusEnum.published.getValue());
		if (model.getEndDate().before(new Date())) {// 重新启动时，如果结束时间在当前时间之前，则将结束时间设为空
			model.setEndDate(null);
		}
		baseService.save(model);
		return LIST_ACTION;
	}

	/**
	 * 终止投票
	 */
	public String stopVote() {
		model = baseService.get(VoteSubject.class, model.getId());
		model.setStatus(VoteStatusEnum.end.getValue());
		model.setEndDate(new Date());// 将终止时间设为当前时间
		baseService.save(model);
		return LIST_ACTION;
	}

	/**
	 * 发布投票
	 */
	public String publishVote() {
		model = baseService.get(VoteSubject.class, model.getId());
		model.setStatus(VoteStatusEnum.published.getValue());
		model.setStartDate(new Date());// 将开始时间设为当前时间
		baseService.save(model);
		return LIST_ACTION;
	}

	public void updateOption() {
		VoteOption option = baseService.get(VoteOption.class, optionId);
		option.setOptionName(optionText);
		baseService.update(option);
		getOut().print("修改选项成功");
	}

	@Override
	public void afterToUpdate(VoteSubject v) {
		Set<User> users = v.getUsers();
		canVoteIds = "";
		for (User user : users) {
			canVoteIds += user.getId() + ",";
		}
		canVoteIds = canVoteIds.substring(0, canVoteIds.length() - 1);
		List<VoteType> types = baseService.find(DetachedCriteria
				.forClass(VoteType.class));
		ActionContext.getContext().put("types", types);
	}

	@Override
	public void beforeSave(VoteSubject model) {
		if (null == model.getId()) {
			model.setStatus(VoteStatusEnum.notPublish.getValue());// 未发布
			User u = (User) ActionContext.getContext().getSession()
					.get(SystemConstant.CURRENT_USER);
			model.setOwner(u);
		}
	}

	public void deleteOption() {
		VoteOption option = baseService.get(VoteOption.class, optionId);
		baseService.delete(option);
		getOut().print("删除选项成功");
	}

	@Override
	public void afterSave(VoteSubject m) {
		Set<VoteOption> options = new HashSet<VoteOption>();
		// 保存选项
		if (null != voteOptions && voteOptions.length != 0) {
			for (String str : voteOptions) {
				if (null != str && str.trim().length() != 0) {
					VoteOption op = new VoteOption();
					op.setOptionName(str);
					op.setSubject(m);
					baseService.add(op);
					options.add(op);
				}
			}
		}
		m.setOptions(options);
		m.setUsers(null);
		baseService.save(m);
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

	public Long getOptionId() {
		return optionId;
	}

	public void setOptionId(Long optionId) {
		this.optionId = optionId;
	}

	public String getOptionText() {
		return optionText;
	}

	public void setOptionText(String optionText) {
		this.optionText = optionText;
	}
}
