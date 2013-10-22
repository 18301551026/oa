package com.lxs.process.action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ModelQuery;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/process")
@Action(value="model", className="processModelAction")
@Results({
	@Result(name="list", location="/WEB-INF/jsp/process/model/list.jsp"),
	@Result(name="add", location="/WEB-INF/jsp/process/model/add.jsp"),
	@Result(name="listAction", type="redirect", location="/process/model!findPage.action"),
	@Result(name="export", type="stream", params = {
			"contentType", "text/plain",
			"inputName", "exportBpmnFile",
			"contentDisposition","attachment;filename='${#exportBpmnFileName}'",
			"bufferSize", "4096"
	})
})
public class ProcessModelAction extends PageAction {

	private static final long serialVersionUID = 1L;

	private String name;
	private String key;
	private String description;
	private String modelId;
	
	@Resource
	private RepositoryService repositoryService;
	
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
		ModelQuery query = repositoryService.createModelQuery();
		
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
			repositoryService.deleteModel(id);
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
	
	public String toAdd() {
		return "add";
	}	

	/**
	 * 创建模型
	 */
	public void add() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode editorNode = objectMapper.createObjectNode();
			editorNode.put("id", "canvas");
			editorNode.put("resourceId", "canvas");
			ObjectNode stencilSetNode = objectMapper.createObjectNode();
			stencilSetNode.put("namespace",
					"http://b3mn.org/stencilset/bpmn2.0#");
			editorNode.put("stencilset", stencilSetNode);
			Model modelData = repositoryService.newModel();

			ObjectNode modelObjectNode = objectMapper.createObjectNode();
			modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
			description = StringUtils.defaultString(description);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION,
					description);
			modelData.setMetaInfo(modelObjectNode.toString());
			modelData.setName(name);
			modelData.setKey(StringUtils.defaultString(key));

			repositoryService.saveModel(modelData);
			repositoryService.addModelEditorSource(modelData.getId(),
					editorNode.toString().getBytes("UTF-8"));

			response.sendRedirect(request.getContextPath()
					+ "/service/editor?id=" + modelData.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据Model部署流程
	 */
	public void deploy() {
		try {
			Model modelData = repositoryService.getModel(modelId);
			ObjectNode modelNode = (ObjectNode) new ObjectMapper()
					.readTree(repositoryService.getModelEditorSource(modelData
							.getId()));
			byte[] bpmnBytes = null;

			BpmnModel model = new BpmnJsonConverter()
					.convertToBpmnModel(modelNode);
			bpmnBytes = new BpmnXMLConverter().convertToXML(model, "UTF-8");

			String processName = modelData.getName() + ".bpmn20.xml";
			Deployment deployment = repositoryService.createDeployment()
					.name(modelData.getName())
					.addString(processName, new String(bpmnBytes)).deploy();
			getOut().print("<script>alert('发布成功');history.go(-1);</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * 导出model的xml文件
	 */
	public InputStream getExportBpmnFile() {
		ByteArrayInputStream in = null;
		try {
			Model modelData = repositoryService.getModel(modelId);
			BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
			JsonNode editorNode = new ObjectMapper().readTree(repositoryService
					.getModelEditorSource(modelData.getId()));
			BpmnModel bpmnModel = jsonConverter.convertToBpmnModel(editorNode);
			BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
			byte[] bpmnBytes = xmlConverter.convertToXML(bpmnModel);
			
			ActionContext.getContext().put("exportBpmnFileName", bpmnModel.getMainProcess().getId() + ".bpmn20.xml");

			in = new ByteArrayInputStream(bpmnBytes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return in;
	}
	
	public String export() {
		return "export";
	}
	

	public void setName(String name) {
		this.name = name;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

}
