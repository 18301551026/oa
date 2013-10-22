package com.lxs.process.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.ManagementService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.IdentityLinkEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.query.NativeQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.Session;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.lxs.core.service.IBaseService;
import com.lxs.process.common.ProcessVariableEnum;
import com.lxs.process.service.IProcessService;
import com.lxs.security.common.SecurityHolder;
import com.lxs.security.domain.Job;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/process")
@Action(value="task", className="processTaskAction")
@Results({
	@Result(name="list", location="/WEB-INF/jsp/process/task/list.jsp"),
	@Result(name="listAction", type="redirect", location="/process/task!findPage.action")
})
public class ProcessTaskAction extends PageAction {

	private static final long serialVersionUID = 1L;

	@Resource
	private TaskService taskService;
	@Resource
	private RepositoryServiceImpl repositoryService;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private IProcessService processService;
	@Resource
	private IBaseService baseService;
	@Resource
	private ManagementService managementService;

	/**
	 * 查询条件
	 */
	private String taskId;
	private String taskName;
	
	protected String[] ids;
	/**
	 * 查询条件
	 */
	protected String definitionKey;
	
	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public String getDefinitionKey() {
		return definitionKey;
	}

	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}	
	
	public String delete() {
		for (String id : ids) {
			taskService.deleteTask(id, true);
		}
		return LIST_ACTION;
	}	
	
	public String findPage() {
		StringBuilder sql = new StringBuilder("select DISTINCT RES.* from "
				+ managementService.getTableName(Task.class) + " RES left join "
				+ managementService.getTableName(IdentityLinkEntity.class) + " I on I.TASK_ID_ = RES.ID_ "
				+ " where RES.ASSIGNEE_ = #{assignee} "
				+ " or I.USER_ID_ = #{candidateUser} "
				+ " or I.GROUP_ID_ IN  ");
		//处理其他页面传递的查询条件
		
		User currentUser = baseService.get(User.class, SecurityHolder
				.getCurrentUser().getId());
		
		StringBuilder candidateGroups = new StringBuilder("(");
		for (Job j : currentUser.getJobs()) {
			candidateGroups.append("'" + j.getJobName() + "',");
		}
		if (candidateGroups.length() > 1) {
			candidateGroups.deleteCharAt(candidateGroups.length() - 1);
		}
		candidateGroups.append(")");
		sql.append(candidateGroups);
		
		NativeQuery query = taskService.createNativeTaskQuery()
			.sql(sql.toString())
			.parameter("assignee", currentUser.getUserName())
			.parameter("candidateUser", currentUser.getUserName());
		List<Task> tasks = query.listPage(start, pageSize);
		Long rowCount = query.sql("select count(*) from (" + sql.toString() + ") t1").count();
		
		PageResult page = new PageResult();
		List<Map<String, Object>> map = doResult(tasks);
		page.setResult(map);
		page.setRowCount(rowCount.intValue());
		ActionContext.getContext().put(PAGE, page);
		
		return LIST;
	}

	public List<Map<String, Object>> doResult(List<?> list) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (Object obj : list) {
			Task task = (Task) obj;
			Map<String, Object> map = new HashMap<String, Object>();
			Object model = taskService.getVariable(task.getId(),
					ProcessVariableEnum.model.toString());
			Object requestUser = taskService.getVariable(task.getId(),
					ProcessVariableEnum.requestUser.toString());			
			map.put("model", model);
			map.put("requestUser", requestUser);
			map.put("task", task);
			ProcessDefinition processDefinition = repositoryService
					.createProcessDefinitionQuery()
					.processDefinitionId(task.getProcessDefinitionId())
					.singleResult();
			map.put("processName", processDefinition.getName());
			result.add(map);
		}
		return result;
	}

	/**
	 * 跳到任务执行页
	 * 
	 * @return
	 */
	public void toTask() throws Exception {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		Object model = taskService.getVariable(taskId,
				ProcessVariableEnum.model.toString());
		Object requestUser = taskService.getVariable(taskId,
				ProcessVariableEnum.requestUser.toString());
		ActionContext.getContext().getValueStack().push(model);
		ActionContext.getContext().put("requestUser", requestUser);

		getButtonsForTransition(task);

		ActionContext.getContext().put("taskName", task.getName());

		// 查询审批意见
		List<Map<String, String>> list = processService.getComments(task
				.getProcessInstanceId());
		ActionContext.getContext().put("commentList", list);

		request.getRequestDispatcher(task.getDescription()).forward(request,
				response);
	}

	private void getButtonsForTransition(Task task) {
		ProcessDefinitionEntity pde = (ProcessDefinitionEntity) repositoryService
				.getDeployedProcessDefinition(task.getProcessDefinitionId());
		ExecutionEntity exe = (ExecutionEntity) runtimeService
				.createExecutionQuery().executionId(task.getExecutionId())
				.singleResult();
		ActivityImpl activity = pde.findActivity(exe.getActivityId());
		List<PvmTransition> transitions = activity.getOutgoingTransitions();
		List<String> buttons = new ArrayList<String>();
		for (PvmTransition pvmTransition : transitions) {
			buttons.add(pvmTransition.getProperty("name").toString());
		}
		ActionContext.getContext().put("buttonList", buttons);
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

}
