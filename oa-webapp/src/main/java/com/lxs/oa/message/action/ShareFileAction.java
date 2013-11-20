package com.lxs.oa.message.action;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;

import com.lxs.core.action.BaseAction;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.message.domain.ShareFile;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("shareFile")
@Results({
		@Result(name = "toIndex", location = "/WEB-INF/jsp/message/shareFile/index.jsp"),
		@Result(name = "toSelectCanDownloadUsers", location = "/WEB-INF/jsp/message/shareFile/selectCanDownloadUsers.jsp"),
		@Result(name = "toUpload", location = "/WEB-INF/jsp/message/shareFile/upload.jsp"),
		@Result(name = "listAction", location = "/person/shareFile!findPage.action?fileTree.id=${fileTree.id}", type = "redirect"),
		@Result(name = "list", location = "/WEB-INF/jsp/message/shareFile/list.jsp"), })
public class ShareFileAction extends BaseAction<ShareFile> {
	private File fileContent;
	private String fileContentFileName;
	private String fileContentContentType;
	private String canDownloadUserIds;

	public String toIndex() {
		return "toIndex";
	}

	public String toUpload() {
		return "toUpload";
	}

	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getFileTree() && null != model.getFileTree().getId()) {
			criteria.createAlias("fileTree", "t");
			criteria.add(Restrictions.eq("t.id", model.getFileTree().getId()));
		}
	}

	public void upload() throws IOException {
		model.setContent(FileCopyUtils.copyToByteArray(fileContent));
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		model.setOwnerUser(u);
		model.setUploadDate(new Date());
		model.setFileName(fileContentFileName);
		model.setSize(formetFileSize(fileContent.length()));
		baseService.add(model);
		getOut().print("成功");
	}

	public String formetFileSize(long fileS) {// 转换文件大小
		DecimalFormat df = new DecimalFormat("#.00");
		String fileSizeString = "";
		if (fileS < 1024) {
			fileSizeString = df.format((double) fileS) + "B";
		} else if (fileS < 1048576) {
			fileSizeString = df.format((double) fileS / 1024) + "K";
		} else if (fileS < 1073741824) {
			fileSizeString = df.format((double) fileS / 1048576) + "M";
		} else {
			fileSizeString = df.format((double) fileS / 1073741824) + "G";
		}
		return fileSizeString;
	}

	public String toSelectCanDownloadUsers() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
		users.remove(currentUser);// 所有人列表
		ActionContext.getContext().put("users", users);
		List<Dept> depts = baseService.find(DetachedCriteria
				.forClass(Dept.class));
		ActionContext.getContext().put("depts", depts);
		return "toSelectCanDownloadUsers";
	}

	public File getFileContent() {
		return fileContent;
	}

	public void setFileContent(File fileContent) {
		this.fileContent = fileContent;
	}

	public String getFileContentFileName() {
		return fileContentFileName;
	}

	public void setFileContentFileName(String fileContentFileName) {
		this.fileContentFileName = fileContentFileName;
	}

	public String getFileContentContentType() {
		return fileContentContentType;
	}

	public void setFileContentContentType(String fileContentContentType) {
		this.fileContentContentType = fileContentContentType;
	}

	public String getCanDownloadUserIds() {
		return canDownloadUserIds;
	}

	public void setCanDownloadUserIds(String canDownloadUserIds) {
		this.canDownloadUserIds = canDownloadUserIds;
	}
}
