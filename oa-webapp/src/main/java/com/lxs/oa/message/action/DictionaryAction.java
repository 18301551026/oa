package com.lxs.oa.message.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.ActivitiBaseAction;
import com.lxs.core.action.BaseAction;
import com.lxs.oa.message.domain.Dictionary;
import com.lxs.security.common.SecurityHolder;

@Controller
@Scope("prototype")
@Namespace("/message")
@Action(value="dictionary", className="dictionaryAction", results={
	@Result(name="add", location="/WEB-INF/jsp/message/dictionary/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/message/dictionary/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/message/dictionary/list.jsp"),
	@Result(name="listAction", type="redirect", location="/message/dictionary!findPage.action")
})
public class DictionaryAction extends BaseAction<Dictionary> {
	
	private static final long serialVersionUID = 1L;

	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getType() && !"".equals(model.getType())) {
			criteria.add(Restrictions.eq("type", model.getType()));
		}
		if (null != model.getName() && !"".equals(model.getName())) {
			criteria.add(Restrictions.like("name", model.getName(), MatchMode.ANYWHERE));
		}
		if (null != model.getValue() && !"".equals(model.getValue())) {
			criteria.add(Restrictions.like("value", model.getValue(), MatchMode.ANYWHERE));
		}
	}

}
