package com.lxs.oa.person.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.BaseAction;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.person.common.MailStatusEnum;
import com.lxs.oa.person.domain.Mail;
import com.lxs.oa.person.domain.Mail_user_;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Actions({
		@Action(className = "mailAction", value = "sendBox", results = {
				@Result(name = "list", location = "/WEB-INF/jsp/person/mail/sendBox.jsp"),
				@Result(name = "listAction", location = "/person/sendBox!findPage.action?mailStatus=${@ com.lxs.oa.person.common.MailStatusEnum@sendBox.value}", type = "redirect"),
				@Result(name = "add", location = "/WEB-INF/jsp/person/mail/add.jsp"),
				@Result(name = "toSelectReceiveUsers", location = "/WEB-INF/jsp/person/mail/selectReceiveUsers.jsp") }),
		@Action(className = "mailAction", value = "receiveBox", results = {
				@Result(name = "list", location = "/WEB-INF/jsp/person/mail/receiveBox.jsp"),
				@Result(name = "turnToOther", location = "/WEB-INF/jsp/person/mail/add.jsp"),
				@Result(name = "toShowDetail", location = "/WEB-INF/jsp/person/mail/mailDetail.jsp"),
				@Result(name = "listAction", location = "/person/receiveBox!findPage.action?mailStatus=${@ com.lxs.oa.person.common.MailStatusEnum@receiveBox.value}", type = "redirect"), }),
		@Action(className = "mailAction", value = "draftBox", results = {
				@Result(name = "list", location = "/WEB-INF/jsp/person/mail/draftBox.jsp"),
				@Result(name = "update", location = "/WEB-INF/jsp/person/mail/edit.jsp"),
				@Result(name = "toSelectReceiveUsers", location = "/WEB-INF/jsp/person/mail/selectReceiveUsers.jsp"),
				@Result(name = "listAction", location = "/person/draftBox!findPage.action?mailStatus=${@ com.lxs.oa.person.common.MailStatusEnum@draftBox.value}", type = "redirect"), }) })
public class MailAction extends BaseAction<Mail> {
	private Long deptId;
	private String receiveUserIds;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		Integer mailStatus = model.getMailStatus();
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		if (mailStatus == MailStatusEnum.receiveBox.getValue()) {// 收件箱
			criteria.add(Restrictions.ne("status",
					MailStatusEnum.draftBox.getValue()));// 邮件不能使放在草稿箱中的
			criteria.createAlias("mailUsers", "mailUsers");
			criteria.add(Restrictions.eq("mailUsers.user.id", u.getId()));
			if (null == model.getStatus()) {
				criteria.add(Restrictions.eq("mailUsers.status",
						MailStatusEnum.noRead.getValue()));// 默认未读
			} else {
				criteria.add(Restrictions.eq("mailUsers.status",
						model.getStatus()));// 已读||未读
			}

		} else {// 发件箱、草稿箱
			criteria.createAlias("sendUser", "u");
			criteria.add(Restrictions.eq("u.id", u.getId()));
			criteria.add(Restrictions.eq("status", mailStatus));
		}
		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
		if (null != model.getMailStatus()) {
			model.setStatus(model.getMailStatus());
		}
	}

	public String toSelectReceiveUsers() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		users.remove(currentUser);// 所有人列表
		ActionContext.getContext().put("users", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);

		if (null != model && model.getId() != null) {
			DetachedCriteria detachedCriteria = DetachedCriteria
					.forClass(Mail_user_.class);
			detachedCriteria.createAlias("mail", "m");
			detachedCriteria.add(Restrictions.eq("m.id", model.getId()));
			List<Mail_user_> list = baseService.find(detachedCriteria);
			ActionContext.getContext().put("selectedMailUsers", list);
			receiveUserIds = "";
			for (Mail_user_ mail_user_ : list) {
				receiveUserIds += mail_user_.getUser().getId() + ",";
			}
			receiveUserIds = receiveUserIds.substring(0,
					receiveUserIds.length() - 1);
		}
		return "toSelectReceiveUsers";
	}

	public void findUserByDept() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(User.class);
		detachedCriteria.createAlias("depts", "d");
		detachedCriteria.add(Restrictions.eq("d.id", deptId));
		List<User> users = baseService.find(detachedCriteria);
		StringBuffer script = new StringBuffer();
		for (User user : users) {
			if (user.getId() == currentUser.getId()) {
				continue;
			}
			script.append("<option value=" + user.getId() + ">"
					+ user.getRealName() + "</option>");
		}
		getOut().print(script);
	}

	@Override
	public String toUpdate() throws Exception {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Mail_user_.class);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", model.getId()));
		List<Mail_user_> list = baseService.find(detachedCriteria);
		receiveUserIds = "";
		for (Mail_user_ mail_user_ : list) {
			receiveUserIds += mail_user_.getUser().getId() + ",";
		}
		receiveUserIds = receiveUserIds.substring(0,
				receiveUserIds.length() - 1);
		ActionContext.getContext().getValueStack()
				.push(baseService.get(Mail.class, model.getId()));
		return UPDATE;
	}

	/*
	 * 将邮件添加到草稿箱
	 */
	public String saveToDraft() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setSendUser(currentUser);
		model.setSendUserName(currentUser.getUserName());
		model.setStatus(MailStatusEnum.draftBox.getValue());
		baseService.add(model);

		addMailUser(model);
		return LIST_ACTION;
	}

	@Override
	public void beforeSave(Mail model) {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setSendUser(currentUser);
		model.setSendUserName(currentUser.getUserName());
		model.setStatus(MailStatusEnum.sendBox.getValue());

		model.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date()));

	}

	public void addMailUser(Mail m) {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		List<User> executeUsers = new ArrayList<User>();
		String userIds[] = receiveUserIds.split(",");
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
		for (User user : executeUsers) {
			if (user.getId() == currentUser.getId()) {
				continue;
			}
			Mail_user_ mu = new Mail_user_();
			mu.setMail(m);
			mu.setStatus(MailStatusEnum.noRead.getValue());
			mu.setUser(user);
			baseService.add(mu);
		}
	}

	@Override
	public void afterSave(Mail m) {
		addMailUser(m);
	}

	public int findNotDeleteCount(Long id) {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Mail_user_.class);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", id));
		return baseService.find(detachedCriteria).size();
	}

	public String turnToOther() {
		ActionContext.getContext().getValueStack()
				.push(baseService.get(Mail.class, model.getId()));
		return "turnToOther";
	}

	@Override
	public String delete() {
		int count = 0;
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		if (model.getStatus() == MailStatusEnum.draftBox.getValue()) {// 还没发送存在草稿箱中
			for (int i = 0; i < ids.length; i++) {
				DetachedCriteria detachedCriteria = DetachedCriteria
						.forClass(Mail_user_.class);
				detachedCriteria.createAlias("mail", "m");
				detachedCriteria.add(Restrictions.eq("m.id", ids[i]));
				List<Mail_user_> list = baseService.find(detachedCriteria);
				for (Mail_user_ mail_user_ : list) {
					baseService.delete(mail_user_);
				}
				baseService.delete(baseService.get(Mail.class, ids[i]));

			}
		} else {
			for (int i = 0; i < ids.length; i++) {
				count = findNotDeleteCount(ids[i]);
				if (model.getStatus() == MailStatusEnum.sendBox.getValue()) {// 发件人删除邮件
					if (count == 0) {// 如果余下0个没有标记为删除时删除此邮件
						Mail m = baseService.get(modelClass, ids[i]);
						baseService.delete(m);
					} else {
						Mail m = baseService.get(modelClass, ids[i]);
						m.setSendUser(null);
						baseService.update(m);

					}
				} else if (model.getStatus() == MailStatusEnum.receiveBox
						.getValue()) {// 收件人删除邮件
					DetachedCriteria detachedCriteria = DetachedCriteria
							.forClass(Mail_user_.class);
					detachedCriteria.createAlias("mail", "m");
					detachedCriteria.add(Restrictions.eq("m.id", ids[i]));
					detachedCriteria.createAlias("user", "u");
					detachedCriteria.add(Restrictions.eq("u.id",
							currentUser.getId()));
					List<Mail_user_> list = baseService.find(detachedCriteria);
					if (null != list && list.size() != 0) {
						Mail_user_ mu = list.get(0);
						baseService.delete(mu);
					}
					if (count == 1) {// 如果余下一个没有标记为删除时删除此邮件
						Mail m = baseService.get(modelClass, ids[i]);
						baseService.delete(m);
					}
				}

			}
		}
		return LIST_ACTION;
	}

	/*
	 * 将草稿箱中的邮件发送出去
	 */
	public String draftBoxToSend() {
		for (int i = 0; i < ids.length; i++) {
			Mail m = baseService.get(Mail.class, ids[i]);
			m.setStatus(MailStatusEnum.sendBox.getValue());
			m.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new Date()));
			baseService.update(m);
		}
		return LIST_ACTION;
	}

	public String toShowDetail() {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Mail_user_.class);
		List<Mail_user_> list = baseService.find(detachedCriteria);
		if (null != list && list.size() != 0) {
			Mail_user_ mu = list.get(0);
			mu.setStatus(MailStatusEnum.readed.getValue());
			baseService.update(mu);
		}

		ActionContext.getContext().getValueStack()
				.push(baseService.get(Mail.class, model.getId()));
		return "toShowDetail";
	}

	public Long getDeptId() {
		return deptId;
	}

	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

	public String getReceiveUserIds() {
		return receiveUserIds;
	}

	public void setReceiveUserIds(String receiveUserIds) {
		this.receiveUserIds = receiveUserIds;
	}

}