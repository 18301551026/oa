package com.lxs.oa.message.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;

import com.lxs.core.action.BaseAction;
import com.lxs.core.common.SystemConstant;
import com.lxs.oa.message.common.FileStatusEnum;
import com.lxs.oa.message.domain.ShareFile;
import com.lxs.oa.person.domain.Attachment;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.User;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/person")
@Actions({
		@Action(className = "shareFileAction", value = "upload", results = {
				@Result(name = "toIndex", location = "/WEB-INF/jsp/message/shareFile/index.jsp"),
				@Result(name = "toSelectCanDownloadUsers", location = "/WEB-INF/jsp/message/shareFile/selectCanDownloadUsers.jsp"),
				@Result(name = "toUpload", location = "/WEB-INF/jsp/message/shareFile/upload.jsp"),
				@Result(name = "listAction", location = "/person/upload!findPage.action?fileTree.id=${fileTree.id}&status=${@com.lxs.oa.message.common.FileStatusEnum@upload.value}", type = "redirect"),
				@Result(name = "list", location = "/WEB-INF/jsp/message/shareFile/list.jsp") }),
		@Action(className = "shareFileAction", value = "download", results = {
				@Result(name = "toIndex", location = "/WEB-INF/jsp/message/shareFile/index.jsp"),
				@Result(name = "download", type = "stream", params = {
//						"contentType", "application/octet-stream;charset=ISO8859-1",
						"inputName", "file", "contentDisposition",
						"attachment;filename=\"${fileName}\"" }),
				@Result(name = "list", location = "/WEB-INF/jsp/message/shareFile/list.jsp") }) })
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
		User u = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		// criteria.createAlias("users", "us",JoinType.LEFT_OUTER_JOIN);
		// criteria.createAlias("ownerUser", "u",JoinType.LEFT_OUTER_JOIN);
		// Criterion c1 = Restrictions.eq("us.id", u.getId());
		// Criterion c2 = Restrictions.eq("u.id", u.getId());
		// criteria.add(Restrictions.or(c1, c2));
		if (model.getStatus() == FileStatusEnum.upload.getValue()) {
			criteria.createAlias("ownerUser", "u");
			criteria.add(Restrictions.eq("u.id", u.getId()));
		} else {
			criteria.createAlias("users", "us");
			criteria.add(Restrictions.eq("us.id", u.getId()));
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

	public InputStream getFile() throws Exception {
		InputStream in = null;
		ShareFile f = baseService.get(ShareFile.class, model.getId());
		f.setFileName(new String(f.getFileName().getBytes("UTF-8"),
				"ISO8859-1"));
		ActionContext.getContext().getValueStack().push(f);
		in = new ByteArrayInputStream(f.getContent());
		return in;
	}

	public String download() {
		return "download";
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

	// 确定可以下载此资源的用户
	public void confirmCanDownloadUsers() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get(SystemConstant.CURRENT_USER);
		List<User> executeUsers = new ArrayList<User>();
		String userIds[] = canDownloadUserIds.split(",");
		if (null != userIds) {
			for (String string : userIds) {
				// 全体人员
				if (string.trim().equals("0")) {
					DetachedCriteria detachedCriteria = DetachedCriteria
							.forClass(User.class);
					executeUsers = baseService.find(detachedCriteria);
					break;
				}
				// 部门人员
				if (string.trim().indexOf("d") != -1) {
					Long deptId = Long.parseLong(string.trim().substring(1));
					DetachedCriteria detachedCriteria = DetachedCriteria
							.forClass(User.class);
					detachedCriteria.createAlias("depts", "d");
					detachedCriteria.add(Restrictions.eq("d.id", deptId));
					List<User> users = baseService.find(detachedCriteria);

					for (User user : users) {
						if (!executeUsers.contains(user)) {
							executeUsers.add(user);
						}
					}
					continue;
				}
				Long userId = Long.parseLong(string.trim());
				DetachedCriteria detachedCriteria = DetachedCriteria
						.forClass(User.class);
				detachedCriteria.add(Restrictions.eq("id", userId));
				List<User> users = baseService.find(detachedCriteria);
				for (User user : users) {
					if (!executeUsers.contains(user)) {
						executeUsers.add(user);
					}
				}
			}
		}
		Set<User> tempSet = new HashSet<User>();
		for (User u : executeUsers) {
			tempSet.add(u);
		}

		ShareFile f = baseService.get(ShareFile.class, model.getId());
		f.setUsers(null);
		f.setUsers(tempSet);
		baseService.save(f);
	}

	public String toSelectCanDownloadUsers() {
		List<User> users = baseService.find(DetachedCriteria
				.forClass(User.class));
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
