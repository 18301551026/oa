package com.lxs.process.activiti;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.delegate.JavaDelegate;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;

import com.lxs.core.service.IBaseService;
import com.lxs.process.common.ProcessVariableEnum;
import com.lxs.process.common.StatusEnum;
import com.lxs.process.domain.ActivitiBaseEntity;

@Component
public class UpdateFailStatusService implements JavaDelegate {

	@Resource
	private IBaseService baseService;

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		ActivitiBaseEntity model = (ActivitiBaseEntity) execution.getVariable(ProcessVariableEnum.model.toString());
		model.setStatus(StatusEnum.fail.getValue());
		baseService.update(model);
	}

}
