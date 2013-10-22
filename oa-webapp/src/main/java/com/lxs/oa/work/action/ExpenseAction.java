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
import com.lxs.oa.work.domain.Expense;
import com.lxs.process.common.StatusEnum;
import com.lxs.security.common.SecurityHolder;

@Controller
@Scope("prototype")
@Namespace("/work")
@Actions({
	@Action(value="expense", className="expenseAction", results={
		@Result(name="add", location="/WEB-INF/jsp/work/expense/add.jsp"),
		@Result(name="update", location="/WEB-INF/jsp/work/expense/update.jsp"),
		@Result(name="list", location="/WEB-INF/jsp/work/expense/list.jsp"),
		@Result(name="listAction", type="redirect", location="/work/expense!findPage.action?status=${@com.lxs.process.common.StatusEnum@unstart.value}"),
		@Result(name="listTask", type="redirect", location="/process/task!findPage.action")
	}),
	@Action(value="expenseStarted", className="expenseAction", results={
		@Result(name="list", location="/WEB-INF/jsp/work/expense/listStarted.jsp")
	}),
	@Action(value="expenseFinished", className="expenseAction", results={
		@Result(name="list", location="/WEB-INF/jsp/work/expense/listFinished.jsp"),
		@Result(name="watch", location="/WEB-INF/jsp/work/expense/watch.jsp")
	})
})
public class ExpenseAction extends ActivitiBaseAction<Expense> {

	@Override
	public void beforeSave(Expense model) {
		if (null == model.getUser()) {
			model.setUser(SecurityHolder.getCurrentUser());
		}
		if (null == model.getStatus()) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getStartMoney()) {
			criteria.add(Restrictions.ge("money", model.getStartMoney()));
		}
		if (null != model.getEndMoney()) {
			criteria.add(Restrictions.le("money", model.getEndMoney()));
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
