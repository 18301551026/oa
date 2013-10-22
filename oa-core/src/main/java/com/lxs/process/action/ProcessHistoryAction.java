package com.lxs.process.action;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/process")
@Action(value="history", className="processHistoryAction")
@Results({
	@Result(name="list", location="/WEB-INF/jsp/process/history/list.jsp"),
	@Result(name="listAction", type="redirect", location="/process/history!findPage.action")
})
public class ProcessHistoryAction extends PageAction {

	private static final long serialVersionUID = 1L;
	
	@Resource
	private HistoryService historyService;
	
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
		HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery();
		query = query.finished();
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
			historyService.deleteHistoricProcessInstance(id);
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

	
}
