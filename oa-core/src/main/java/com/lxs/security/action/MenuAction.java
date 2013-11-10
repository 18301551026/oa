package com.lxs.security.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lxs.core.action.BaseAction;
import com.lxs.core.cache.ClearCache;
import com.lxs.core.common.BeanUtil;
import com.lxs.security.common.SecurityHolder;
import com.lxs.security.domain.Menu;
import com.lxs.security.service.IMenuService;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
@Namespace("/security")
@Action(value = "menu", className = "menuAction")
@Results({
		@Result(name = "list", location = "/WEB-INF/jsp/security/menu/menu.jsp"),
		@Result(name = "add", location = "/WEB-INF/jsp/security/menu/add.jsp"),
		@Result(name = "toOrderMenu", location = "/WEB-INF/jsp/security/menu/order.jsp"),
		@Result(name = "update", location = "/WEB-INF/jsp/security/menu/update.jsp") })
public class MenuAction extends BaseAction<Menu> {

	@Resource
	private IMenuService menuService;
	private Long roleId;
	private String json2Order;

	/**
	 * 忽略Menu的parent属性
	 */
	private static abstract class IgnoreParentMixIn {
		@JsonIgnore
		public abstract Menu getParent();
	}

	/**
	 * 忽略Menu的children属性
	 */
	private static abstract class IgnoreChildrenMixIn {
		@JsonIgnore
		public abstract List<Menu> getChildren();
	}

	public void setJson2Order(String json2Order) {
		this.json2Order = json2Order;
	}

	/**
	 * 查询所有菜单
	 */
	// public void findMenu() throws Exception {
	// List<Menu> list = menuService.findRootMenu();
	//
	// ObjectMapper objectMapper = new ObjectMapper();
	// objectMapper.addMixInAnnotations(Menu.class, IgnoreParentMixIn.class);
	// objectMapper.writeValue(getOut(), list);
	// }
	public void findMenu() throws Exception {
		List<Menu> list = menuService.findRootMenu();
		for (Menu menu : list) {
			if (null != menu.getParent()) {
				menu.setPid(menu.getParent().getId());
			}
			List<Menu> childMenus = menu.getChildren();
			if (childMenus != null && childMenus.size() != 0) {
				menu.setState("closed");// 节点以文件夹的形式体现
			} else {
				menu.setState("open");// 节点以文件的形式体现
			}
		}
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.addMixInAnnotations(Menu.class, IgnoreParentMixIn.class);
		objectMapper.writeValue(getOut(), list);
	}

	/**
	 * 查询所有菜单，选中角色的菜单
	 */
	public void findCheckedMenuByRole() throws Exception {
		List<Menu> list = menuService.findCheckedMenuByRole(roleId);

		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.addMixInAnnotations(Menu.class, IgnoreParentMixIn.class);
		objectMapper.writeValue(getOut(), list);
	}

	/**
	 * 查询属于当前用户的菜单
	 */
	public void findMenuByUser() throws Exception {
		List<Menu> list = menuService.findRootMenuByUser(SecurityHolder
				.getCurrentUser().getId());

		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.addMixInAnnotations(Menu.class, IgnoreParentMixIn.class);
		objectMapper.writeValue(getOut(), list);
	}

	/**
	 * 添加根节点，添加子节点
	 * 
	 * @throws Exception
	 */
	@ClearCache
	public void saveMenu() throws Exception {
		// Map<String, Object> result = new HashMap<String, Object>();
		if (null != model.getPid()) {
			model.setParent(baseService.get(modelClass, model.getPid()));
		}
		if (null == model.getOpen()) {
			model.setOpen(false);
		}

		// Menu entity = null;
		// if (null == model.getId()) {
		// result.put("addSign", true);
		// entity = modelClass.newInstance();
		// } else {
		// result.put("addSign", false);
		// entity = baseService.get(modelClass, model.getId());
		// }
		// BeanUtil.copy(model, entity);
		baseService.save(model);
		// TODO jacksong转换hibernate代理对象报错
		// if (null != entity.getParent()) {
		// Menu parent = new Menu();
		// parent.setId(entity.getParent().getId());
		// entity.setParent(parent);
		// }
		// result.put("node", entity);
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.addMixInAnnotations(Menu.class, IgnoreChildrenMixIn.class);
		objectMapper.writeValue(getOut(), model);
	}

	public String toOrderMenu() {
		return "toOrderMenu";
	}

	/**
	 * 删除菜单
	 * 
	 * @throws Exception
	 */
	public void deleteMenu() throws Exception {
		baseService.delete(model);

		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.addMixInAnnotations(Menu.class, IgnoreParentMixIn.class);
		objectMapper.writeValue(getOut(), model);
	}

	public String toUpdate() {
		return LIST;
	}

	/**
	 * 保存菜单排序，和菜单关系
	 */
	public void saveMenuOrder() throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		List<Menu> list = objectMapper.readValue(json2Order,
				new TypeReference<List<Menu>>() {
				});
		menuService.saveMenuOrder(list);
		getOut().print("{'success': true}");
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String toEdit() {
		ActionContext.getContext().getValueStack()
				.push(baseService.get(modelClass, model.getId()));
		return UPDATE;
	}
}
