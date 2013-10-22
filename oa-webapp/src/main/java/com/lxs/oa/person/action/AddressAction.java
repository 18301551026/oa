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
import com.lxs.oa.common.AddressTypeEnum;
import com.lxs.oa.person.domain.Address;
import com.lxs.security.common.SecurityHolder;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action(value="address", className="addressAction", results={
	@Result(name="add", location="/WEB-INF/jsp/person/address/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/person/address/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/person/address/list.jsp"),
	@Result(name="listAction", type="redirect", location="/person/address!findPage.action?type=${type}")
})
public class AddressAction extends BaseAction<Address> {
	
	@Override
	public void beforeSave(Address model) {
		if (null == model.getUser()) {
			model.setUser(SecurityHolder.getCurrentUser());
		}
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getType()) {
			criteria.add(Restrictions.eq("type", model.getType()));
		}
		if (AddressTypeEnum.person.toString().equals(model.getType())) {
			criteria.createAlias("user", "u");
			criteria.add(Restrictions.eq("u.id", SecurityHolder.getCurrentUser().getId()));
		}
		if (null != model.getFirstName() && !"".equals(model.getFirstName())) {
			criteria.add(Restrictions.like("firstName", model.getFirstName(), MatchMode.ANYWHERE));
		}
		if (null != model.getSecondName() && !"".equals(model.getSecondName())) {
			criteria.add(Restrictions.like("secondName", model.getSecondName(), MatchMode.ANYWHERE));
		}
		if (null != model.getCompanyName() && !"".equals(model.getCompanyName())) {
			criteria.add(Restrictions.like("companyName", model.getCompanyName(), MatchMode.ANYWHERE));
		}
		if (null != model.getFixedPhone() && !"".equals(model.getFixedPhone())) {
			criteria.add(Restrictions.like("fixedPhone", model.getFixedPhone(), MatchMode.ANYWHERE));
		}
	}

}
