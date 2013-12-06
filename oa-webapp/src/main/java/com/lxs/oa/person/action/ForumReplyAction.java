package com.lxs.oa.person.action;

import java.util.Date;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.BaseAction;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.person.domain.ForumReply;
import com.lxs.oa.person.domain.ForumSubject;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("reply")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/person/forum/reply.jsp"),
		@Result(name = "listAction", location = "/person/reply!findPage.action?subjectId=${subjectId}", type = "redirect") })
public class ForumReplyAction extends BaseAction<ForumReply> {
	private Long subjectId;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		criteria.addOrder(Order.desc("createDate"));
		criteria.createAlias("subject", "s");
		criteria.add(Restrictions.eq("s.id", subjectId));
		ActionContext.getContext().put("sub",
				baseService.get(ForumSubject.class, subjectId));
	}

	@Override
	public void beforeSave(ForumReply model) {
		model.setSubject(baseService.get(ForumSubject.class, subjectId));
		model.setCreateDate(new Date());
		model.setUser((User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER));
	}

	public Long getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(Long subjectId) {
		this.subjectId = subjectId;
	}
}
