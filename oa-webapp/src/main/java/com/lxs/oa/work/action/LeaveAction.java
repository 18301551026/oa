package com.lxs.oa.work.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.ActivitiBaseAction;
import com.lxs.oa.work.domain.Leave;
import com.lxs.process.common.StatusEnum;
import com.lxs.security.common.SecurityHolder;

@Controller
@Scope("prototype")
@Namespace("/work")
@Actions({
	@Action(value="leave", className="leaveAction", results={
		@Result(name="add", location="/WEB-INF/jsp/work/leave/add.jsp"),
		@Result(name="update", location="/WEB-INF/jsp/work/leave/update.jsp"),
		@Result(name="list", location="/WEB-INF/jsp/work/leave/list.jsp"),
		@Result(name="listAction", type="redirect", location="/work/leave!findPage.action?status=${@com.lxs.process.common.StatusEnum@unstart.value}"),
		@Result(name="listTask", type="redirect", location="/process/task!findPage.action")
	}),
	@Action(value="leaveStarted", className="leaveAction", results={
		@Result(name="list", location="/WEB-INF/jsp/work/leave/listStarted.jsp")
	}),
	@Action(value="leaveFinished", className="leaveAction", results={
		@Result(name="list", location="/WEB-INF/jsp/work/leave/listFinished.jsp"),
		@Result(name="watch", location="/WEB-INF/jsp/work/leave/watch.jsp")
	})
})
public class LeaveAction extends ActivitiBaseAction<Leave> {
	
	@Override
	public void beforeSave(Leave model) {
		if (null == model.getUser()) {
			model.setUser(SecurityHolder.getCurrentUser());
		}
		if (null == model.getStatus()) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getStartDate()) {
			criteria.add(Restrictions.ge("startDate", model.getStartDate()));
		}
		if (null != model.getEndDate()) {
			criteria.add(Restrictions.le("startDate", model.getEndDate()));
		}
		if (null != model.getStatus()) {
			if (StatusEnum.finished.getValue().equals(model.getStatus())) {
				Criterion c1 = Restrictions.eq("status", StatusEnum.success.getValue());
				Criterion c2 = Restrictions.eq("status", StatusEnum.fail.getValue());
				criteria.add(Restrictions.or(c1, c2));
			} else {
				criteria.add(Restrictions.eq("status", model.getStatus()));
			}
		}
		if (null == model.getQueryByAllUser() || "".equals(model.getQueryByAllUser())) {
			criteria.createAlias("user", "u");
			criteria.add(Restrictions.eq("u.id", SecurityHolder.getCurrentUser().getId()));
		}
	}

}
