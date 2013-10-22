package com.lxs.security.dao.impl;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.lxs.security.dao.IMenuDao;
import com.lxs.security.domain.Menu;

@Repository
public class MenuDaoImpl implements IMenuDao {
	
	@Resource
	private SessionFactory sessionFactory;
	
	@Override
	public List<Menu> findRootMenu() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Menu.class);
		criteria.add(Restrictions.isNull("parent"));
		criteria.addOrder(Order.asc("order"));
		
		criteria.setCacheable(true);
		List<Menu> list = criteria.list();
		
		return list;
	}
	
	
	@Override
	public List<Menu> findMenuByUser(Long userId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Menu.class);
		criteria.createAlias("roles", "r");
		criteria.createAlias("r.users", "u");
		criteria.add(Restrictions.eq("u.id", userId));
		
		//FIXME 关联查询的缓存有问题
		criteria.setCacheable(true);
		return criteria.list();
	}	
	
	@Override
	public List<Menu> findMenuByRole(Long roleId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Menu.class);
		criteria.createAlias("roles", "r");
		criteria.add(Restrictions.eq("r.id", roleId));
		
		criteria.setCacheable(true);
		return criteria.list();
	}	
	
	@Override
	public void saveMenuOrder(List<Menu> list) {
		for (int i = 0; i < list.size(); i++) {
			Menu m = list.get(i);
			Menu menu = (Menu) sessionFactory.getCurrentSession().get(Menu.class, m.getId());
			menu.setOrder(m.getOrder());
			if (null == m.getParent().getId()) {
				menu.setParent(null);
			} else {
				menu.setParent(m.getParent());	
			}
			sessionFactory.getCurrentSession().update(menu);
		    if ( i % 20 == 0 ) { //清楚缓存
		        sessionFactory.getCurrentSession().flush();
		        sessionFactory.getCurrentSession().clear();
		    }			
		}
	}	
	
	@Override
	public List<Menu> setMenuChecked(List<Menu> rootMenu, List<Menu> userMenu) {
		for (Menu menu : rootMenu) {
			if (userMenu.contains(menu)) {
				menu.setChecked(true);
			}
			if (null != menu.getChildren() && menu.getChildren().size() > 0) {
				setMenuChecked(menu.getChildren(), userMenu);
			}
		}
		return rootMenu;
	}
	
	@Override
	public List<Menu> removeNotUserMenu(List<Menu> rootMenu, List<Menu> userMenu) {
		Iterator<Menu> it = rootMenu.iterator();
		while (it.hasNext()) {
			Menu menu = it.next();
			if (!userMenu.contains(menu)) {
				it.remove();
			}
			if (null != menu.getChildren() && menu.getChildren().size() > 0) {
				removeNotUserMenu(menu.getChildren(), userMenu);
			}
		}
		return rootMenu;
	}
	
}
