package com.lxs.process.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;

import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/process")
@Action(value = "definition", className = "processDefinitionAction")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/process/definition/list.jsp"),
		@Result(name = "upload", location = "/WEB-INF/jsp/process/definition/upload.jsp"),
		@Result(name = "listAction", type = "redirect", location = "/process/definition!findPage.action") })
public class ProcessDefinitionAction extends PageAction {

	private static final long serialVersionUID = 1L;

	@Resource
	private RepositoryService repositoryService;

	private File process;
	private String processFileName;
	private String definitionId;

	/**
	 * 查询条件
	 */
	private String definitionName;

	protected String[] ids;
	/**
	 * 查询条件
	 */
	protected String definitionKey;

	/**
	 * 分页查询
	 * 
	 * @return
	 */
	public String findPage() {
		ProcessDefinitionQuery query = repositoryService
				.createProcessDefinitionQuery();
		// 查询条件
		if (null != definitionName && !"".equals(definitionName.trim())) {
			query.processDefinitionNameLike(definitionName);
		}
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
			repositoryService.deleteDeployment(id, true);
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

	/**
	 * 流程定义转换模型
	 */
	public void convert2Model() {
		try {
			ProcessDefinition processDefinition = repositoryService
					.createProcessDefinitionQuery()
					.processDefinitionId(definitionId).singleResult();

			InputStream bpmnStream = repositoryService.getResourceAsStream(
					processDefinition.getDeploymentId(),
					processDefinition.getResourceName());
			XMLInputFactory xif = XMLInputFactory.newInstance();
			InputStreamReader in = new InputStreamReader(bpmnStream, "UTF-8");
			XMLStreamReader xtr = xif.createXMLStreamReader(in);
			BpmnModel bpmnModel = new BpmnXMLConverter()
					.convertToBpmnModel(xtr);

			if (bpmnModel.getMainProcess() == null
					|| bpmnModel.getMainProcess().getId() == null) {
				getOut().print("转换失败...");
			} else {

				if (bpmnModel.getLocationMap().size() == 0) {
					getOut().print("转换失败...");
				} else {

					BpmnJsonConverter converter = new BpmnJsonConverter();
					ObjectNode modelNode = converter.convertToJson(bpmnModel);
					Model modelData = repositoryService.newModel();

					ObjectNode modelObjectNode = new ObjectMapper()
							.createObjectNode();
					modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME,
							processDefinition.getName());
					modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION,
							1);
					modelObjectNode.put(
							ModelDataJsonConstants.MODEL_DESCRIPTION,
							processDefinition.getDescription());
					modelData.setMetaInfo(modelObjectNode.toString());
					modelData.setName(processDefinition.getName());

					repositoryService.saveModel(modelData);

					repositoryService.addModelEditorSource(modelData.getId(),
							modelNode.toString().getBytes("utf-8"));

					response.sendRedirect(request.getServletContext()
							.getContextPath()
							+ "/service/editor?id="
							+ modelData.getId());
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 跳到上传业务表单页面
	 * 
	 * @return
	 */
	public String toUpload() {
		List<String> list = new ArrayList<String>();

		String path = getPath();
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
		for (File f : file.listFiles()) {
			list.add(f.getName());
		}
		ActionContext.getContext().put("fileList", list);

		return "upload";
	}

	private String getPath() {
		String path = request.getServletContext().getRealPath("/")
				+ "/WEB-INF/jsp/process/taskform/" + definitionKey + "/";
		return path;
	}

	public String upload() throws Exception {
		String path = getPath();
		InputStream in = new FileInputStream(process);
		OutputStream out = new FileOutputStream(path + processFileName);
		FileCopyUtils.copy(in, out);
		return LIST_ACTION;
	}

	public String getDefinitionName() {
		return definitionName;
	}

	public void setDefinitionName(String definitionName) {
		this.definitionName = definitionName;
	}

	public void setProcess(File process) {
		this.process = process;
	}

	public void setProcessFileName(String processFileName) {
		this.processFileName = processFileName;
	}

	public void setDefinitionId(String definitionId) {
		this.definitionId = definitionId;
	}

}
