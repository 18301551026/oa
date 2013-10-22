package com.lxs.core.action;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.task.Task;

import com.lxs.core.common.BeanUtil;
import com.lxs.process.domain.ActivitiBaseEntity;
import com.lxs.process.service.IProcessService;
import com.lxs.security.common.SecurityHolder;
import com.opensymphony.xwork2.ActionContext;

public abstract class ActivitiBaseAction<T> extends BaseAction<T> {

	private static final long serialVersionUID = -4393074864539616294L;

	@Resource
	private TaskService taskService;
	@Resource
	private IProcessService processService;
	@Resource
	private HistoryService historyService;

	private String taskId;
	private String transition;
	private String definitionKey;
	/**
	 * 审批意见
	 */
	private String comment;

	/**
	 * 启动流程
	 * 
	 * @return
	 */
	public String start() {
		for (Long id : ids) {
			ActivitiBaseEntity entity = (ActivitiBaseEntity) baseService.get(modelClass, id);
			processService.doStart(entity, definitionKey);
		}
		return LIST_ACTION;
	}

	/**
	 * 执行任务
	 * 
	 * @return
	 */
	public String performTask() {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		processService.doTask(transition, task, model, SecurityHolder.getCurrentUser(), comment);
		return "listTask";
	}

	/**
	 * 审批结束的查看
	 * 
	 * @return
	 */
	public String watch() throws Exception {
		Method idGetter = BeanUtil.getMethod(modelClass, ID_GET_METHOD);
		// 掉用getId方法得到id
		Long id = (Long) idGetter.invoke(model);
		beforToUpdate();
		T entity = baseService.get(modelClass, id);
		afterToUpdate(entity);
		ActionContext.getContext().getValueStack().push(entity);

		HistoricProcessInstance processInstance = historyService.createHistoricProcessInstanceQuery()
				.processDefinitionKey(definitionKey)
				.processInstanceBusinessKey(id.toString()).singleResult();
		
		List<Map<String, String>> list = processService.getComments(processInstance.getId());
		
		ActionContext.getContext().put("commentList", list);

		return "watch";
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public void setTransition(String transition) {
		this.transition = transition;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}

}
