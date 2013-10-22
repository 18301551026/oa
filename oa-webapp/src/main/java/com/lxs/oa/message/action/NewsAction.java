package com.lxs.oa.message.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.action.BaseAction;
import com.lxs.oa.message.domain.Dictionary;
import com.lxs.oa.message.domain.News;

@Controller
@Scope("prototype")
@Namespace("/message")
@Action(value="news", className="newsAction", results={
	@Result(name="add", location="/WEB-INF/jsp/message/news/add.jsp"),
	@Result(name="update", location="/WEB-INF/jsp/message/news/update.jsp"),
	@Result(name="list", location="/WEB-INF/jsp/message/news/list.jsp"),
	@Result(name="listAction", type="redirect", location="/message/news!findPage.action")
})
public class NewsAction extends BaseAction<News> {
	
	private static final long serialVersionUID = 1L;
	
	public List<Dictionary> getDictionarys() {
		DetachedCriteria criteria = DetachedCriteria.forClass(Dictionary.class);
		criteria.add(Restrictions.eq("type", "新闻类型"));
		return baseService.find(criteria);
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getType() && !"".equals(model.getType())) {
			criteria.add(Restrictions.eq("type", model.getType()));
		}
		if (null != model.getTitle() && !"".equals(model.getTitle())) {
			criteria.add(Restrictions.like("title", model.getTitle(), MatchMode.ANYWHERE));
		}
	}

}
