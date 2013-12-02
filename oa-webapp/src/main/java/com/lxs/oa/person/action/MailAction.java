package com.lxs.oa.person.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import org.springframework.util.FileCopyUtils;

import com.lxs.core.action.BaseAction;
import com.lxs.core.common.BeanUtil;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.person.common.MailStatusEnum;
import com.lxs.oa.person.domain.Attachment;
import com.lxs.oa.person.domain.Mail;
import com.lxs.oa.person.domain.MailUser;
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
				@Result(name = "toProtalMail", location = "/WEB-INF/jsp/protal/mail.jsp"),
				@Result(name = "turnToOther", location = "/WEB-INF/jsp/person/mail/add.jsp"),
				@Result(name = "toShowProtalMail", location = "/WEB-INF/jsp/protal/readMail.jsp"),
				@Result(name = "download", type = "stream", params = {
						"inputName", "file", "contentDisposition",
						"attachment;filename=\"${attName}\"" }),
				@Result(name = "toShowDetail", location = "/WEB-INF/jsp/person/mail/mailDetail.jsp"),
				@Result(name = "listAction", location = "/person/receiveBox!findPage.action?mailStatus=${@ com.lxs.oa.person.common.MailStatusEnum@receiveBox.value}", type = "redirect") }),
		@Action(className = "mailAction", value = "draftBox", results = {
				@Result(name = "list", location = "/WEB-INF/jsp/person/mail/draftBox.jsp"),
				@Result(name = "update", location = "/WEB-INF/jsp/person/mail/edit.jsp"),
				@Result(name = "toSelectReceiveUsers", location = "/WEB-INF/jsp/person/mail/selectReceiveUsers.jsp"),
				@Result(name = "listAction", location = "/person/draftBox!findPage.action?mailStatus=${@ com.lxs.oa.person.common.MailStatusEnum@draftBox.value}", type = "redirect") }) })
public class MailAction extends BaseAction<Mail> {
	private Long deptId;
	private String receiveUserIds;
	private File attach[];
	private String attachFileName[];
	private Long attId;
	private Long mailId;
	private Long tempStatus;

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

	public void protalReplyMail() {
		model.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm")
				.format(new Date()));
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setSendUser(u);
		model.setSendUserName(u.getRealName());
		model.setStatus(MailStatusEnum.sendBox.getValue());
		baseService.save(model);

		MailUser mu = new MailUser();
		mu.setMail(model);
		mu.setStatus(MailStatusEnum.noRead.getValue());
		Mail tempM = baseService.get(Mail.class, mailId);
		mu.setUser(tempM.getSendUser());
		baseService.save(mu);
		getOut().print("成功");
	}

	public String getTopNoReadMail() {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Mail.class);
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		detachedCriteria.createAlias("mailUsers", "ms");
		detachedCriteria.add(Restrictions.eq("ms.user.id", u.getId()));// 收件人是当前用户
		detachedCriteria.add(Restrictions.eq("status",
				MailStatusEnum.sendBox.getValue()));// 已发送
		detachedCriteria.add(Restrictions.eq("ms.status",
				MailStatusEnum.noRead.getValue()));// 未读
		List<Mail> mails = (List<Mail>) (baseService.find(detachedCriteria, 0,
				5).getResult());
		ActionContext.getContext().put("mails", mails);
		return "toProtalMail";
	}

	public String toSelectReceiveUsers() {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		ActionContext.getContext().put("users", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);

		return "toSelectReceiveUsers";
	}

	public String toShowProtalMail() {
		Mail m = baseService.get(Mail.class, model.getId());
		ActionContext.getContext().getValueStack().push(m);

		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(MailUser.class);
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", m.getId()));
		detachedCriteria.createAlias("user", "u");
		detachedCriteria.add(Restrictions.eq("u.id", u.getId()));
		List<MailUser> mus = baseService.find(detachedCriteria);
		if (null != mus && mus.size() != 0) {//修改状态为已读
			MailUser mu = mus.get(0);
			mu.setStatus(MailStatusEnum.readed.getValue());
			baseService.save(mu);
		}
		return "toShowProtalMail";
	}

	public InputStream getFile() throws Exception {
		InputStream in = null;
		Attachment att = baseService.get(Attachment.class, attId);
		att.setAttName((new String(att.getAttName().getBytes("UTF-8"),
				"ISO8859-1")));
		ActionContext.getContext().getValueStack().push(att);
		in = new ByteArrayInputStream(att.getContent());
		return in;
	}

	public String download() {
		return "download";
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
				.forClass(MailUser.class);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", model.getId()));
		List<MailUser> list = baseService.find(detachedCriteria);
		receiveUserIds = "";
		for (MailUser mail_user_ : list) {
			receiveUserIds += mail_user_.getUser().getId() + ",";
		}
		receiveUserIds = receiveUserIds.substring(0,
				receiveUserIds.length() - 1);
		ActionContext.getContext().getValueStack()
				.push(baseService.get(Mail.class, model.getId()));
		return UPDATE;
	}

	public String draftBoxSave() {

		return LIST_ACTION;
	}

	// 修改草稿箱中的邮件
	public String updateToDraft() {
		Mail temp = baseService.get(Mail.class, model.getId());
		BeanUtil.copy(model, temp);
		baseService.update(temp);
		// 删除原来的收件人
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(MailUser.class);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", model.getId()));
		List<MailUser> oldMus = baseService.find(detachedCriteria);
		for (MailUser mail_user_ : oldMus) {
			baseService.delete(mail_user_);
		}

		addMailUser(temp);// 添加新的收件人
		return LIST_ACTION;
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

		// addMailUser(model);
		afterSave(model);
		return LIST_ACTION;
	}

	public void deleteAtt() {
		baseService.delete(baseService.get(Attachment.class, attId));
		getOut().print("成功");
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
			MailUser mu = new MailUser();
			mu.setMail(m);
			mu.setStatus(MailStatusEnum.noRead.getValue());
			mu.setUser(user);
			baseService.add(mu);
		}
	}

	@Override
	public void afterSave(Mail m) {
		try {
			if (null != attach && attach.length != 0) {
				for (int i = 0; i < attach.length; i++) {
					File f = attach[i];
					Attachment att = new Attachment();
					att.setMail(m);
					att.setAttName(attachFileName[i]);
					att.setContent(FileCopyUtils.copyToByteArray(f));
					baseService.add(att);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		addMailUser(m);
	}

	public int findNotDeleteCount(Long id) {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(MailUser.class);
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
						.forClass(MailUser.class);
				detachedCriteria.createAlias("mail", "m");
				detachedCriteria.add(Restrictions.eq("m.id", ids[i]));
				List<MailUser> list = baseService.find(detachedCriteria);
				for (MailUser mail_user_ : list) {
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
							.forClass(MailUser.class);
					detachedCriteria.createAlias("mail", "m");
					detachedCriteria.add(Restrictions.eq("m.id", ids[i]));
					detachedCriteria.createAlias("user", "u");
					detachedCriteria.add(Restrictions.eq("u.id",
							currentUser.getId()));
					List<MailUser> list = baseService.find(detachedCriteria);
					if (null != list && list.size() != 0) {
						MailUser mu = list.get(0);
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

	public String draftBoxMailsToSend() {

		for (int i = 0; i < ids.length; i++) {
			Mail m = baseService.get(Mail.class, ids[i]);
			m.setStatus(MailStatusEnum.sendBox.getValue());
			m.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new Date()));
			baseService.update(m);
		}
		return LIST_ACTION;
	}

	/*
	 * 将草稿箱中的邮件发送出去
	 */
	public String draftBoxToSend() {

		Mail temp = baseService.get(Mail.class, model.getId());
		BeanUtil.copy(model, temp);
		temp.setStatus(MailStatusEnum.sendBox.getValue());
		temp.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date()));
		baseService.update(temp);
		// 删除原来的收件人
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(MailUser.class);
		detachedCriteria.createAlias("mail", "m");
		detachedCriteria.add(Restrictions.eq("m.id", model.getId()));
		List<MailUser> oldMus = baseService.find(detachedCriteria);
		for (MailUser mail_user_ : oldMus) {
			baseService.delete(mail_user_);
		}

		// addMailUser(temp);添加新的收件人
		afterSave(temp);

		return LIST_ACTION;
	}

	public String toShowDetail() {
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(MailUser.class);
		List<MailUser> list = baseService.find(detachedCriteria);
		if (null != list && list.size() != 0) {
			MailUser mu = list.get(0);
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

	public File[] getAttach() {
		return attach;
	}

	public void setAttach(File[] attach) {
		this.attach = attach;
	}

	public String[] getAttachFileName() {
		return attachFileName;
	}

	public void setAttachFileName(String[] attachFileName) {
		this.attachFileName = attachFileName;
	}

	public Long getAttId() {
		return attId;
	}

	public void setAttId(Long attId) {
		this.attId = attId;
	}

	public Long getTempStatus() {
		return tempStatus;
	}

	public void setTempStatus(Long tempStatus) {
		this.tempStatus = tempStatus;
	}

	public Long getMailId() {
		return mailId;
	}

	public void setMailId(Long mailId) {
		this.mailId = mailId;
	}

}
