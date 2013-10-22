package com.lxs.process.dao;

import java.util.List;

import com.lxs.security.domain.User;

public interface IProcessDao {

	/**
	 * 查询当前用户的部门主管
	 * @param userId
	 * @return
	 */
	public abstract List<User> findDeptManager2User(Long userId);

}