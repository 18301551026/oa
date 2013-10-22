package com.lxs.process.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Attachment;
import org.activiti.engine.task.Task;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.lxs.core.common.BeanUtil;
import com.lxs.core.common.SystemConstant;
import com.lxs.process.common.JobEnum;
import com.lxs.process.common.ProcessVariableEnum;
import com.lxs.process.common.StatusEnum;
import com.lxs.process.dao.IProcessDao;
import com.lxs.process.domain.ActivitiBaseEntity;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;

@Repository
@SuppressWarnings("unchecked")
public class ProcessDaoImpl implements IProcessDao {
	@Resource
	private SessionFactory sessionFactory;

	@Override
	public List<User> findDeptManager2User(Long userId) {
		User user = (User) sessionFactory.getCurrentSession().get(User.class, userId);
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.createAlias("depts", "d");
		criteria.createAlias("jobs", "j");
		criteria.add(Restrictions.eq("j.jobName", JobEnum.deptManager.getValue()));
		List<Long> userDepts = new ArrayList<Long>();
		for (Dept d : user.getDepts()) {
			userDepts.add(d.getId());
		}
		criteria.add(Restrictions.in("d.id", userDepts));
		return criteria.list();
	}
	
	
}
