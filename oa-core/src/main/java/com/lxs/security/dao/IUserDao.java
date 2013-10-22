package com.lxs.security.dao;

import org.hibernate.SessionFactory;

import com.lxs.security.domain.User;

public interface IUserDao {

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

}