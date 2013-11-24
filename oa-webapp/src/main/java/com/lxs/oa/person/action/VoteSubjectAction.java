package com.lxs.oa.person.action;

import java.util.List;

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
import com.lxs.oa.person.domain.VoteSubject;
import com.lxs.oa.person.domain.VoteType;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("voteSubject")
@Results({
	@Result(name="list",location="/WEB-INF/jsp/person/vote/list.jsp"),
	@Result(name="add",location="/WEB-INF/jsp/person/vote/add.jsp")
})
public class VoteSubjectAction extends BaseAction<VoteSubject> {
	private String [] voteOptions[];
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null!=model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),MatchMode.ANYWHERE));
		}
		User u=(User)ActionContext.getContext().getSession().get(SystemConstant.CURRENT_USER);
		criteria.createAlias("owner", "u");
		criteria.add(Restrictions.eq("u.id", u.getId()));
	}
	@Override
	public void beforToAdd() {
		List<VoteType> types=baseService.find(DetachedCriteria.forClass(VoteType.class));
		ActionContext.getContext().put("types", types);
	}
	public String[][] getVoteOptions() {
		return voteOptions;
	}
	public void setVoteOptions(String[][] voteOptions) {
		this.voteOptions = voteOptions;
	}
}
