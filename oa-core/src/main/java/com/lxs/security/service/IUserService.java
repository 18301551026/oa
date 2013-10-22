package com.lxs.security.service;

import org.hibernate.SessionFactory;

import com.lxs.security.domain.User;

public interface IUserService {

	/**
	 * 登陆
	 * @param userName
	 * @param password
	 * @return
	 */
	public abstract User login(String userName, String password);

	/**
	 * 判断当前用户，有没有访问当前地址的权限
	 * @param userId 当前用户主键
	 * @param path 当前访问地址
	 * @return
	 */
	public abstract boolean validateAuth(Long userId, String path);
	
	/**
	 * 为用户添加角色
	 * @return
	 */
	public abstract void addRole(Long roleId, Long userId);

	/**
	 * 为用户删除角色
	 * @return
	 */
	public abstract void deleteRole(Long roleId, Long userId);

	/**
	 * 为用户添加部门
	 * @return
	 */
	public abstract void addDept(Long deptId, Long userId);

	/**
	 * 为用户删除部门
	 * @return
	 */
	public abstract void deleteDept(Long deptId, Long userId);

	/**
	 * 为用户添加职位
	 * @return
	 */

	public abstract void addJob(Long jobId, Long userId);

	/**
	 * 为用户删除职位
	 * @return
	 */
	public abstract void deleteJob(Long jobId, Long userId);	

}