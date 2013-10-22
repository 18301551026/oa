package com.lxs.process.service;

import java.util.List;
import java.util.Map;

import org.activiti.engine.task.Task;

import com.lxs.process.domain.ActivitiBaseEntity;
import com.lxs.security.domain.User;

public interface IProcessService {

	/**
	 * 启动流程
	 * @param entity
	 * @param definitionKey
	 */
	public abstract void doStart(ActivitiBaseEntity entity, String definitionKey);

	/**
	 * 查询当前用户的部门主管
	 * @param userId
	 * @return
	 */
	public abstract List<User> findDeptManager2User(Long userId);

	/**
	 * 执行任务
	 * @param transition ：seqenceFlow的名字,用于驳回
	 * @param task       ：任务
	 * @param model      : 业务数据
	 * @param currentUser：申请人
	 * @param comment：审批意见
	 */
	public abstract void doTask(String transition, Task task, Object model,
			User currentUser, String comment);

	/**
	 * 查询流程实例的审批意见
	 * @param processInstance
	 * @return
	 */
	public abstract List<Map<String, String>> getComments(
			String processInstanceId);

}