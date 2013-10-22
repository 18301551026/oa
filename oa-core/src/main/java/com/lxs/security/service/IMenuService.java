package com.lxs.security.service;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;

import com.lxs.core.cache.ClearCache;
import com.lxs.security.domain.Menu;

public interface IMenuService {

	/**
	 * 查询所有根菜单
	 * @return
	 */
	public abstract List<Menu> findRootMenu();

	/**
	 * 查询用户的菜单，用于left.jsp
	 * @param userId
	 * @return
	 */
	public abstract List<Menu> findRootMenuByUser(Long userId);

	/**
	 * 查询所有菜单，设置用户的菜单checked=true
	 * @param userId
	 * @return
	 */
	public abstract List<Menu> findCheckedMenuByRole(Long roleId);

	/**
	 * 保存菜单的排序字段和父节点关系
	 * @param list
	 */
	public abstract void saveMenuOrder(List<Menu> list);	

	
}