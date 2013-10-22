package com.lxs.process.activiti;

import javax.annotation.Resource;

import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.activiti.engine.task.Attachment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Component;

@Component
public class TimeoutExecutionListener implements JavaDelegate {
	
	@Resource
	private TaskService taskService;

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		Task task = taskService.createTaskQuery().processInstanceId(execution.getProcessInstanceId()).list().get(0);
		Attachment attachment = taskService.createAttachment("comment", task.getId(), execution.getProcessInstanceId(), "", "审批超时，流程自动结束", "");
		taskService.saveAttachment(attachment);
	}

}
