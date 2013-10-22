package com.lxs.security.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lxs.core.cache.ClearCache;
import com.lxs.core.dao.IBaseDao;
import com.lxs.security.dao.IUserDao;
import com.lxs.security.domain.Dept;
import com.lxs.security.domain.Job;
import com.lxs.security.domain.Role;
import com.lxs.security.domain.User;
import com.lxs.security.service.IUserService;

@Service
public class UserServiceImpl implements IUserService {
	
	@Resource
	private IUserDao userDao;
	@Resource
	private IBaseDao baseDao;
	
	@Override
	public User login(String userName, String password) {
		return userDao.login(userName, password);
	}

	@Override
	public boolean validateAuth(Long userId, String path) {
		return userDao.validateAuth(userId, path);
	}

	@Override
	@ClearCache
	public void addRole(Long roleId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Role role = baseDao.get(Role.class, roleId);
		
		role.getUsers().add(user);
		baseDao.save(role);		
	}

	@Override
	@ClearCache
	public void deleteRole(Long roleId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Role role = baseDao.get(Role.class, roleId);
		
		role.getUsers().remove(user);
		baseDao.save(role);		
	}

	@Override
	public void addDept(Long deptId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Dept dept = baseDao.get(Dept.class, deptId);
		user.getDepts().add(dept);
		baseDao.save(user);		
	}

	@Override
	public void deleteDept(Long deptId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Dept dept = baseDao.get(Dept.class, deptId);
		user.getDepts().remove(dept);
		baseDao.save(user);		
	}

	@Override
	public void addJob(Long jobId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Job job = baseDao.get(Job.class, jobId);
		user.getJobs().add(job);
		baseDao.save(user);		
	}

	@Override
	public void deleteJob(Long jobId, Long userId) {
		User user = baseDao.get(User.class, userId);
		Job job = baseDao.get(Job.class, jobId);
		user.getJobs().remove(job);
		baseDao.save(user);		
	}

}
