package com.lxs.process.activiti;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.stereotype.Component;

import com.lxs.process.common.ProcessVariableEnum;
import com.lxs.process.domain.ActivitiBaseEntity;
import com.lxs.process.service.IProcessService;
import com.lxs.security.domain.User;

@Component
public class DeptManagerListener implements TaskListener {

	@Resource
	private IProcessService processService;

	@Override
	public void notify(DelegateTask task) {
		User requestUser = (User) task.getVariable(ProcessVariableEnum.requestUser.toString());
		List<User> users = processService.findDeptManager2User(requestUser.getId());
		for (User u : users) {
			task.addCandidateUser(u.getUserName());
		}
	}

}
