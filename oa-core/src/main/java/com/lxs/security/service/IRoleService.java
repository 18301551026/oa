package com.lxs.security.service;

import com.lxs.core.cache.ClearCache;

public interface IRoleService {

	/**
	 * 为角色分配菜单
	 * @param roleId
	 * @param menuIds
	 */
	public abstract void doAssignMenu2Role(Long roleId, Long[] menuIds);
	
	public void addUser(Long userId, Long roleId);
	
	public void deleteUser(Long userId, Long roleId);
	
	public void addResource(Long resourceId, Long roleId);
	
	public void deleteResource(Long resourceId, Long roleId);
	

}