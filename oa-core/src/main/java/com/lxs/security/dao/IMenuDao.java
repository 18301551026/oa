package com.lxs.security.dao;

import java.util.List;

import com.lxs.core.cache.ClearCache;
import com.lxs.security.domain.Menu;

public interface IMenuDao {
	
	/**
	 * 查询所有根菜单
	 * @return
	 */
	public abstract List<Menu> findRootMenu();

	/**
	 * 保存菜单的排序字段和父节点关系
	 * @param list
	 */
	public abstract void saveMenuOrder(List<Menu> list);	

	/**
	 * 查询用户的菜单
	 * @param userId
	 * @return
	 */
	public abstract List<Menu> findMenuByUser(Long userId);

	/**
	 * 查询角色的菜单
	 * @param userId
	 * @return
	 */
	public abstract List<Menu> findMenuByRole(Long roleId);

	/**
	 * 递归设置菜单checked
	 * @param menus
	 * @param userMenu
	 */
	public abstract List<Menu> setMenuChecked(List<Menu> rootMenu,
			List<Menu> userMenu);

	/**
	 * 递归删除不属于用户的菜单
	 * @param menus
	 * @param userMenu
	 */
	public abstract List<Menu> removeNotUserMenu(List<Menu> rootMenu,
			List<Menu> userMenu);

}