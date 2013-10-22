package com.lxs.security.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.lxs.security.dao.IUserDao;
import com.lxs.security.domain.Resource;
import com.lxs.security.domain.Role;
import com.lxs.security.domain.User;

@Repository
public class UserDaoImpl implements IUserDao {
	
	@javax.annotation.Resource
	private SessionFactory sessionFactory;
	
	@Override
	public User login(String userName, String password) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("userName", userName));
		criteria.add(Restrictions.eq("password", password));
		User user = (User) criteria.uniqueResult();
		return user;
	}
	
	@Override
	public boolean validateAuth(Long userId, String path) {
		Resource resource = getResourceForPath(path);
		
		return doValidate(userId, resource);
	}

	private boolean doValidate(Long userId, Resource resource) {
		//判断用户的角色是否属于资源的某一个角色,属于：有权限,不属于：没权限
		if (resource != null) {
			User currentUser = (User) sessionFactory.getCurrentSession().get(User.class, userId);
			for (Role resourceRole : resource.getRoles()) {
				for (Role userRole : currentUser.getRoles()) {
					if (resourceRole.getId().equals(userRole.getId())) {
						return true;
					}
				}
			}
			return false;
		} else {
			return true;
		}
	}

	private Resource getResourceForPath(String path) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Resource.class);
		criteria.setCacheable(true);
		List<Resource> resources = criteria.list();
		Resource resource = null;
		for (Resource r : resources) {
			//找到跟访问地址"path"匹配的resource
			if (path.matches(r.getUrl())) {
				if (resource == null) {
					resource = r;
				} else {
					//url长度长的优先级高
					if (resource.getUrl().length() < r.getUrl().length()) {
						resource = r;
					}				
				}
			}
		}
		return resource;
	}
	
	
}
