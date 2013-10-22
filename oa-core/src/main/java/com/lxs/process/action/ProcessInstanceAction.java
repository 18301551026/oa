package com.lxs.process.action;

import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.ProcessEngineImpl;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;

import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/process")
@Action(value="instance", className="processInstanceAction")
@Results({
	@Result(name="list", location="/WEB-INF/jsp/process/instance/list.jsp"),
	@Result(name="watch", location="/WEB-INF/jsp/process/instance/watch.jsp"),
	@Result(name="listAction", type="redirect", location="/process/instance!findPage.action")
})
public class ProcessInstanceAction extends PageAction {

	private static final long serialVersionUID = 1L;

	@Resource
	private ProcessEngineImpl processEngine;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private RepositoryServiceImpl repositoryService;
	@Resource
	private HistoryService historyService;

	/**
	 * 流程实例的Id
	 */
	private String id;
	private String definitionId;
	
	protected String[] ids;
	/**
	 * 查询条件
	 */
	protected String definitionKey;
	
	/**
	 * 分页查询
	 * @return
	 */
	public String findPage() {
		ProcessInstanceQuery query = runtimeService
				.createProcessInstanceQuery();
		if (null != definitionKey && !"".equals(definitionKey.trim())) {
			query.processDefinitionKey(definitionKey);
		}

		
		long rowCount = query.count();
		List<?> result = query.listPage(start, pageSize);
		PageResult page = new PageResult();
		page.setRowCount(rowCount);
		page.setResult(result);
		ActionContext.getContext().put(PAGE, page);
		return LIST;
	}
	
	public String delete() {
		for (String id : ids) {
			runtimeService.deleteProcessInstance(id, "删除原因测试");
		}
		return LIST_ACTION;
	}
	
	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public String getDefinitionKey() {
		return definitionKey;
	}

	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}	

	public String watch() {
		return "watch";
	}

	public void picture() throws Exception {
		if (null != definitionId && !"".equals(definitionId.trim())) {
			definitionKey = repositoryService.createProcessDefinitionQuery().processDefinitionId(definitionId).singleResult().getKey();
		}
		ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery().processInstanceBusinessKey(id, definitionKey)
				.singleResult();
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
		
		List<Execution> executions = runtimeService.createExecutionQuery().processInstanceId(processInstance.getId()).list();
		//正在活动的activity的id
		//TODO 未验证是否可行
		List<String> activeIds = runtimeService.getActiveActivityIds(processInstance.getId());
//		List<String> activeIds = new ArrayList<String>(); 
//		for (Execution exe : executions) {
//			List<String> list = runtimeService.getActiveActivityIds(exe.getId());
//			activeIds.addAll(list);
//		}
		
		// 使用spring注入引擎请使用下面的这行代码
		Context.setProcessEngineConfiguration(processEngine.getProcessEngineConfiguration());
		InputStream in = ProcessDiagramGenerator.generateDiagram(bpmnModel, "png", activeIds);
		
		FileCopyUtils.copy(in, response.getOutputStream());
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public void setDefinitionId(String definitionId) {
		this.definitionId = definitionId;
	}

}
