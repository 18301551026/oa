package com.lxs.oa.message.action;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;
import com.lxs.core.action.BaseAction;
import com.lxs.oa.message.dao.IShareFileTreeDao;
import com.lxs.oa.message.domain.ShareFile;
import com.lxs.oa.message.domain.ShareFileTree;

@Controller
@Scope("prototype")
@Namespace("/person")
@Action("shareFileTree")
@Results({
		@Result(name = "add", location = "/WEB-INF/jsp/message/shareFile/addNode.jsp"),
		@Result(name = "update", location = "/WEB-INF/jsp/message/shareFile/updateNode.jsp") })
public class ShareFileTreeAction extends BaseAction<ShareFileTree> {
	private Long pid;
	@Resource
	private IShareFileTreeDao treeDao;

/*	*//**
	 * 忽略tree的parent属性
	 *//*
	private static abstract class IgnoreParentMixIn {
		@JsonIgnore
		public abstract ShareFileTree getParent();
	}

	*//**
	 * 忽略tree的children属性
	 *//*
	private static abstract class IgnoreChildrenMixIn {
		@JsonIgnore
		public abstract List<ShareFileTree> getChildren();
	}*/

	/**
	 * 查询所有菜单
	 */
	public void getTree() throws Exception {
		List<ShareFileTree> list = treeDao.findRootMenu();
		for (ShareFileTree t : list) {
			List<ShareFileTree> childTrees = t.getChildren();
			if (childTrees != null && childTrees.size() != 0) {
				t.setState("closed");// 节点以文件夹的形式体现
			} else {
				t.setState("open");// 节点以文件的形式体现
			}
		}
		
		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(ShareFileTree.class);
		filter.getExcludes().add("parent");
		getOut().print(JSON.toJSONString(list, filter));
	}

	public void addNode() {
		if (null!=pid) {
			model.setParent(baseService.get(ShareFileTree.class, pid));
		}
		baseService.add(model);
		
		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(ShareFileTree.class);
		filter.getExcludes().add("children");
		getOut().print(JSON.toJSONString(model, filter));
	}

	public void deleteNode() {
		ShareFileTree t = baseService.get(ShareFileTree.class, model.getId());
		Set<ShareFile> f = t.getFiles();
		if (null != f && f.size() != 0) {
			for (ShareFile shareFile : f) {
				baseService.delete(shareFile);
			}
		}
		baseService.delete(t);
		
		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(ShareFileTree.class);
		filter.getExcludes().add("children");
		getOut().print(JSON.toJSONString(model, filter));		
	}

	public void updateNode() {
		baseService.save(model);
		
		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(ShareFileTree.class);
		filter.getExcludes().add("children");
		getOut().print(JSON.toJSONString(model, filter));			
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}
}
