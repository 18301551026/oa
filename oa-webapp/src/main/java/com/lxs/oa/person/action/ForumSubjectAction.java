package com.lxs.oa.person.action;

import java.util.Date;
import java.util.Iterator;

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
import com.lxs.oa.person.domain.ForumReply;
import com.lxs.oa.person.domain.ForumSubject;
import com.lxs.oa.work.domain.Module;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("subject")
@Results({ @Result(name = "list", location = "/WEB-INF/jsp/person/forum/subject.jsp"),
	@Result(name="listAction",location="/person/subject!findPage.action?moduleId=${moduleId}",type="redirect"),
	@Result(name="update",location="/WEB-INF/jsp/person/forum/updateSubject.jsp"),
		@Result(name="add",location="/WEB-INF/jsp/person/forum/addSubject.jsp")
})
public class ForumSubjectAction extends BaseAction<ForumSubject> {
	private Long moduleId;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		criteria.createAlias("module", "m");
		criteria.add(Restrictions.eq("m.id", moduleId));
		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
	}
	@Override
	public void beforeDelete(ForumSubject m) {
		Iterator<ForumReply> iterator=m.getReplies().iterator();
		while(iterator.hasNext()){
			ForumReply r=iterator.next();
			baseService.delete(r);
		}
		m.setReplies(null);
	}
	@Override
	public void beforeSave(ForumSubject f) {
		User u=(User)ActionContext.getContext().getSession().get(SystemConstant.CURRENT_USER);
		f.setUser(u);
		f.setCreateDate(new Date());
		f.setModule(baseService.get(Module.class, moduleId));
	}
	public Long getModuleId() {
		return moduleId;
	}

	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}
}
