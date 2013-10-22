package com.lxs.security.service;

public interface IResourceService {
	
	/**
	 * 为资源添加角色
	 * @return
	 */
	public void addRole(Long roleId, Long resourceId);
	
	/**
	 * 为资源删除角色
	 * @return
	 */
	public void deleteRole(Long roleId, Long resourceId);	

}
