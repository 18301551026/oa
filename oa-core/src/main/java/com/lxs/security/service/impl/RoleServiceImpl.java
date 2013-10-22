package com.lxs.security.service.impl;

import java.util.HashSet;

import org.springframework.stereotype.Service;

import com.lxs.core.cache.ClearCache;
import com.lxs.core.dao.IBaseDao;
import com.lxs.security.domain.Menu;
import com.lxs.security.domain.Resource;
import com.lxs.security.domain.Role;
import com.lxs.security.domain.User;
import com.lxs.security.service.IRoleService;

@Service
public class RoleServiceImpl implements IRoleService {
	
	@javax.annotation.Resource
	private IBaseDao baseDao;

	@Override
	@ClearCache
	public void doAssignMenu2Role(Long roleId, Long[] menuIds) {
		Role role = baseDao.get(Role.class, roleId);
		role.setMenus(null);
		baseDao.update(role);
		
		role.setMenus(new HashSet<Menu>());
		for (Long id : menuIds) {
			Menu m = new Menu();
			m.setId(id);
			role.getMenus().add(m);
		}
		baseDao.update(role);
	}

	@Override
	@ClearCache
	public void addUser(Long userId, Long roleId) {
		Role role = baseDao.get(Role.class, roleId);
		User user = baseDao.get(User.class, userId);
		
		role.getUsers().add(user);
		baseDao.save(role);
	}

	@Override
	@ClearCache
	public void deleteUser(Long userId, Long roleId) {
		Role role = baseDao.get(Role.class, roleId);
		User user = baseDao.get(User.class, userId);
		
		role.getUsers().remove(user);
		baseDao.save(role);
	}

	@Override
	@ClearCache
	public void addResource(Long resourceId, Long roleId) {
		Role role = baseDao.get(Role.class, roleId);
		Resource resource = baseDao.get(Resource.class, resourceId);
		
		role.getResources().add(resource);
		baseDao.save(role);
	}

	@Override
	@ClearCache
	public void deleteResource(Long resourceId, Long roleId) {
		Role role = baseDao.get(Role.class, roleId);
		Resource resource = baseDao.get(Resource.class, resourceId);
		
		role.getResources().remove(resource);
		baseDao.save(role);
	}

}
