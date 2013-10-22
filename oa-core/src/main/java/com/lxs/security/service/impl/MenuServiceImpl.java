package com.lxs.security.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lxs.core.cache.ClearCache;
import com.lxs.security.dao.IMenuDao;
import com.lxs.security.domain.Menu;
import com.lxs.security.service.IMenuService;

@Service
public class MenuServiceImpl implements IMenuService {
	
	@Resource
	private IMenuDao menuDao;
	
	@Override
	public List<Menu> findRootMenu() {
		return menuDao.findRootMenu();
	}
	
	@Override
	public List<Menu> findRootMenuByUser(Long userId) {
		List<Menu> userMenu = menuDao.findMenuByUser(userId);
		List<Menu> rootMenu = menuDao.findRootMenu();
		return menuDao.removeNotUserMenu(rootMenu, userMenu);
	}	
	
	@Override
	public List<Menu> findCheckedMenuByRole(Long roleId) {
		List<Menu> userMenu = menuDao.findMenuByRole(roleId);
		List<Menu> rootMenu = menuDao.findRootMenu();
		return menuDao.setMenuChecked(rootMenu, userMenu);
	}

	@Override
	@ClearCache
	public void saveMenuOrder(List<Menu> list) {
		menuDao.saveMenuOrder(list);
	}


}
