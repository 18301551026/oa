package com.lxs.oa.person.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.BaseAction;
import com.lxs.oa.person.domain.WorkPlan;
import com.lxs.security.common.SecurityHolder;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action(value="plan", className="workPlanAction", results={
	@Result(name="add", location="/WEB-INF/jsp/person/plan/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/person/plan/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/person/plan/list.jsp"),
	@Result(name="listAction", type="redirect", location="/person/plan!findPage.action")
})
public class WorkPlanAction extends BaseAction<WorkPlan> {
	
	@Override
	public void beforeSave(WorkPlan model) {
		if (null == model.getUser()) {
			model.setUser(SecurityHolder.getCurrentUser());
		}
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getTitle() && !"".equals(model.getTitle())) {
			criteria.add(Restrictions.like("title", model.getTitle(), MatchMode.ANYWHERE));
		}
	}

}
