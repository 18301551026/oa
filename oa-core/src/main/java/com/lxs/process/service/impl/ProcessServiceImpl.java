package com.lxs.process.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Attachment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import com.lxs.core.common.BeanUtil;
import com.lxs.core.common.SystemConstant;
import com.lxs.core.dao.IBaseDao;
import com.lxs.process.common.ProcessVariableEnum;
import com.lxs.process.common.StatusEnum;
import com.lxs.process.dao.IProcessDao;
import com.lxs.process.domain.ActivitiBaseEntity;
import com.lxs.process.service.IProcessService;
import com.lxs.security.domain.User;

@Service
public class ProcessServiceImpl implements IProcessService {
	
	@Resource
	private IProcessDao processDao;
	@Resource
	private IBaseDao baseDao;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private HistoryService historyService;
	@Resource
	private TaskService taskService;	

	
	@Override
	public List<User> findDeptManager2User(Long userId) {
		return processDao.findDeptManager2User(userId);
	}	
	
	@Override
	public void doStart(ActivitiBaseEntity entity, String definitionKey) {
		entity.setStatus(StatusEnum.start.getValue());
		baseDao.save(entity);
		
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put(ProcessVariableEnum.model.toString(), entity);
		variables.put(ProcessVariableEnum.requestUser.toString(), entity.getUser());
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(definitionKey, entity.getId()
				.toString(), variables);
		
		Task task = taskService.createTaskQuery().processInstanceId(processInstance.getId()).singleResult();
		taskService.complete(task.getId());
	}	

	@Override
	public void doTask(String transition, Task task, Object model, User currentUser, String comment) {
		if (null != comment && !"".equals(comment.trim())) {
			Attachment attachment = taskService.createAttachment("comment", task.getId(), task.getProcessInstanceId(), currentUser.getUserName(), comment, "");
			taskService.saveAttachment(attachment);
		}
		
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put(ProcessVariableEnum.transition.toString(), transition);

		if (SystemConstant.REQUEST_TASK.equals(task.getName())) {
			ActivitiBaseEntity m = (ActivitiBaseEntity) model;
			ActivitiBaseEntity entity = (ActivitiBaseEntity) baseDao.get(model.getClass(), m.getId());
			BeanUtil.copy(model, entity);
			baseDao.save(entity);
			variables.put(ProcessVariableEnum.model.toString(), entity);
		}
		
		taskService.claim(task.getId(), currentUser.getUserName());
		taskService.complete(task.getId(), variables);
		
	}	
	

	@Override
	public List<Map<String, String>> getComments(String processInstanceId) {
		List<Attachment> attachments = taskService
				.getProcessInstanceAttachments(processInstanceId);
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for (Attachment comment : attachments) {
			Map<String, String> map = new HashMap<String, String>();
			HistoricTaskInstance t = historyService
					.createHistoricTaskInstanceQuery()
					.taskId(comment.getTaskId()).singleResult();
			String commentName = t.getName() + "(" + comment.getName() + ")";
			map.put("taskName", commentName);
			map.put("comment", comment.getDescription());
			list.add(map);
		}
		return list;
	}	

}
