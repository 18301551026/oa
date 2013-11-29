package com.lxs.oa.person.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSON;
import com.lxs.core.action.BaseAction;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.work.common.VoteStatusEnum;
import com.lxs.oa.work.domain.VoteOption;
import com.lxs.oa.work.domain.VoteSubject;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("vote")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/person/vote/list.jsp"),
		@Result(name = "toVote", location = "/WEB-INF/jsp/person/vote/vote.jsp"),
		@Result(name = "toDetail", location = "/WEB-INF/jsp/person/vote/voteDetail.jsp") })
public class VoteAction extends BaseAction<VoteSubject> {
	@Override
	public void beforFind(DetachedCriteria criteria) {
		//每次查询之前都会自动搜索已经到期的投票将之设为已终止
		DetachedCriteria detachedCriteria=DetachedCriteria.forClass(VoteSubject.class);
		detachedCriteria.add(Restrictions.eq("status", VoteStatusEnum.published.getValue()));
		detachedCriteria.add(Restrictions.le("endDate", new Date()));
		List<VoteSubject> endSubjects=baseService.find(detachedCriteria);
		if (null!=endSubjects&&endSubjects.size()!=0) {
			for (VoteSubject endSubject: endSubjects) {
				endSubject.setStatus(VoteStatusEnum.end.getValue());
				baseService.save(endSubject);
			}
		}
		
		if (null != model.getTitle()) {
			criteria.add(Restrictions.like("title", model.getTitle(),
					MatchMode.ANYWHERE));
		}
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		criteria.createAlias("users", "us");
		criteria.add(Restrictions.eq("us.id", u.getId()));
		criteria.add(Restrictions.eq("status",
				VoteStatusEnum.published.getValue()));
	}

	/**
	 * 跳到投票页面
	 * 
	 * @return
	 */
	public String toVote() {
		ActionContext.getContext().getValueStack()
				.push(baseService.get(VoteSubject.class, model.getId()));
		return "toVote";
	}

	/**
	 * 检查当前用户是否已经投过票了
	 */
	public void checkVoted() {
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(VoteOption.class);
		detachedCriteria.createAlias("users", "us");
		detachedCriteria.add(Restrictions.eq("us.id", u.getId()));
		detachedCriteria.createAlias("subject", "s");
		detachedCriteria.add(Restrictions.eq("s.id", model.getId()));
		List<VoteOption> options = baseService.find(detachedCriteria);
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (null != options && options.size() != 0) {
			map.put("success", true);
		} else {
			map.put("success", false);
		}
		getOut().print(JSON.toJSON(map));

	}

	/**
	 * 投票
	 */
	public void vote() {
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		for (Long oid : ids) {
			VoteOption option = baseService.get(VoteOption.class, oid);
			option.getUsers().add(u);
			Integer nums = option.getNums();
			if (null == nums || nums == 0) {
				nums = 1;
			} else {
				nums += 1;
			}
			option.setNums(nums);
			baseService.update(option);
		}
		getOut().print("成功");
	}

	public int getPercent(int totalCount, int num) {
		if (totalCount == 0) {
			return 0;
		} else {
			int per = (num * 100 / totalCount);
			if ((num * 100 % totalCount) * 10 / totalCount > 5) {
				per += 1;
			}
			return per;
		}

	}

	public String toShowVoteDetail() {
		model = baseService.get(VoteSubject.class, model.getId());
		List<Long> hadVoteUserIds = new ArrayList<Long>();
		Set<VoteOption> options = model.getOptions();
		int totalVoteNums = 0;
		for (VoteOption voteOption : options) {
			for (User u : voteOption.getUsers()) {
				if (!hadVoteUserIds.contains(u.getId())) {
					hadVoteUserIds.add(u.getId());
				}
			}
			totalVoteNums += voteOption.getUsers().size();
		}
		for (VoteOption voteOption : options) {
			voteOption.setPercent(getPercent(totalVoteNums, voteOption
					.getUsers().size()));
		}
		model.setHadUserVoteNum(hadVoteUserIds.size());
		ActionContext.getContext().getValueStack().push(model);
		return "toDetail";
	}
}
