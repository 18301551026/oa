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
import com.lxs.security.domain.Dept;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value="dept", className="deptAction")
@Results({
	@Result(name="add", location="/WEB-INF/jsp/security/dept/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/security/dept/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/security/dept/list.jsp"),
	@Result(name="listAction", type="redirect", location="/security/dept!findPage.action")
	
})
public class DeptAction extends BaseAction<Dept> {
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getDeptName() && !"".equals(model.getDeptName())) {
			criteria.add(Restrictions.like("deptName", model.getDeptName(),
					MatchMode.ANYWHERE));
		}
	}
	
}
