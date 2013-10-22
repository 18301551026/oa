package com.lxs.security.action;

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
import com.lxs.security.domain.Job;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value="job", className="jobAction")
@Results({
	@Result(name="add", location="/WEB-INF/jsp/security/job/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/security/job/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/security/job/list.jsp"),
	@Result(name="listAction", type="redirect", location="/security/job!findPage.action")
	
})
public class JobAction extends BaseAction<Job> {
	
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getJobName() && !"".equals(model.getJobName().trim())) {
			criteria.add(Restrictions.like("jobName", model.getJobName(), MatchMode.ANYWHERE));
		}
	}

}
