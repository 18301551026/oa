package com.lxs.security.service.impl;

import org.springframework.stereotype.Service;

import com.lxs.core.cache.ClearCache;
import com.lxs.core.dao.IBaseDao;
import com.lxs.security.domain.Resource;
import com.lxs.security.domain.Role;
import com.lxs.security.service.IResourceService;

@Service
public class ResourceServiceImpl implements IResourceService {
	
	@javax.annotation.Resource
	private IBaseDao baseDao;

	@Override
	@ClearCache
	public void addRole(Long roleId, Long resourceId) {
		//要添加的角色
		Role role = baseDao.get(Role.class, roleId);
		//要添加角色的资源
		Resource resource = baseDao.get(Resource.class, resourceId);
		//为资源添加角色
		role.getResources().add(resource);
		//保存角色，因为角色管理关联关系
		baseDao.save(role);
	}

	@Override
	@ClearCache
	public void deleteRole(Long roleId, Long resourceId) {
		//要删除的角色
		Role role = baseDao.get(Role.class, roleId);
		//要删除角色的资源
		Resource resource = baseDao.get(Resource.class, resourceId);
		//为资源删除角色
		role.getResources().remove(resource);
		//保存角色，因为角色管理关联关系
		baseDao.save(role);		
	}

}
