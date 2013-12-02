package com.lxs.oa.person.action;

import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SimpleDateFormatSerializer;
import com.lxs.core.action.BaseAction;
import com.lxs.core.common.BeanUtil;
import com.lxs.core.common.SystemConstant;
import com.lxs.core.common.TimeUtil;
import com.lxs.oa.person.domain.Schedule;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("schedule")
@Results({
		@Result(name = "toIndex", location = "/WEB-INF/jsp/person/schedule/index.jsp"),
		@Result(name = "toProtalSchedule", location = "/WEB-INF/jsp/protal/schedule.jsp"),
		@Result(name = "add", location = "/WEB-INF/jsp/person/schedule/add.jsp"),
		@Result(name = "toShowProtalScheduleDetail", location = "/WEB-INF/jsp/protal/readSchedule.jsp"),
		@Result(name = "update", location = "/WEB-INF/jsp/person/schedule/edit.jsp") })
public class ScheduleAction extends BaseAction<Schedule> {
	// 定制化mapping
	private static SerializeConfig mapping = new SerializeConfig();
	static {
		mapping.put(Date.class, new SimpleDateFormatSerializer(
				"yyyy-MM-dd HH:mm"));
	}

	public String toIndex() {
		return "toIndex";
	}

	@Override
	public void afterToUpdate(Schedule entity) {
		entity.setStrStartDate(entity.getStart().toString());
		entity.setStrEndDate(entity.getEnd().toString());
	}

	@Override
	public void beforToAdd() {
		System.out.println(model.getStrStartDate() + "\t"
				+ model.getStrEndDate());
	}

	public String toShowProtalScheduleDetail() {
		ActionContext.getContext().getValueStack()
				.push(baseService.get(Schedule.class, model.getId()));
		return "toShowProtalScheduleDetail";
	}

	public String getTodayTop5Schedule() {
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Schedule.class);
		detachedCriteria.createAlias("user", "u");
		detachedCriteria.add(Restrictions.eq("u.id", u.getId()));
		TimeUtil tt = new TimeUtil();
		Date nowTime = TimeUtil.strToDate(tt.getNowTime("yyyy-MM-dd"),
				"yyyy-MM-dd");
		Criterion c1 = Restrictions.ge("start", nowTime);
		Criterion c2 = Restrictions.lt("start",
				TimeUtil.getDateAfter(nowTime, 1));
		detachedCriteria.add(Restrictions.and(c1, c2));
		List<Schedule> schedules = (List<Schedule>) baseService.find(
				detachedCriteria, 0, 5).getResult();
		ActionContext.getContext().put("schedules", schedules);
		return "toProtalSchedule";
	}

	public static void main(String[] args) {
		TimeUtil tt = new TimeUtil();
		String str = tt.getNowTime("yyyy-MM-dd");
		Date nowTime = TimeUtil.strToDate(str, "yyyy-MM-dd");
		System.out.println(str);
		System.out.println(nowTime);

	}

	public void allSchedules() {
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		DetachedCriteria detachedCriteria = DetachedCriteria
				.forClass(Schedule.class);
		detachedCriteria.createAlias("user", "u");
		detachedCriteria.add(Restrictions.eq("u.id", u.getId()));
		List<Schedule> schedules = baseService.find(detachedCriteria);
		getOut().print(
				JSON.toJSONStringWithDateFormat(schedules, "yyyy-MM-dd HH:mm"));
	}

	public void deleteSchedule() {
		baseService.delete(baseService.get(Schedule.class, model.getId()));
		getOut().print("成功");
	}

	public void addSchedule() {
		model.setStart(TimeUtil.strToDate(model.getStrStartDate(),
				"yyyy-MM-dd HH:mm"));
		model.setEnd(TimeUtil.strToDate(model.getStrEndDate(),
				"yyyy-MM-dd HH:mm"));
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setUser(u);
		baseService.save(model);
		getOut().print("成功");
	}

	public void updateSchedule() {
		Schedule s = baseService.get(Schedule.class, model.getId());
		BeanUtil.copy(model, s);
		baseService.save(s);
		getOut().print("成功");
	}

	public void dragSchedule() {
		model.setStart(TimeUtil.strToDate(model.getStrStartDate(),
				"yyyy-MM-dd HH:mm"));
		model.setEnd(TimeUtil.strToDate(model.getStrEndDate(),
				"yyyy-MM-dd HH:mm"));
		Schedule s = baseService.get(Schedule.class, model.getId());
		BeanUtil.copy(model, s);
		baseService.save(s);
		getOut().print("成功");
	}
}
