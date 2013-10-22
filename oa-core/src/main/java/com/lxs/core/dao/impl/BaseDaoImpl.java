package com.lxs.core.dao.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.orm.hibernate3.HibernateInterceptor;
import org.springframework.stereotype.Repository;

import com.lxs.core.common.page.PageResult;
import com.lxs.core.dao.IBaseDao;

@Repository
public class BaseDaoImpl implements IBaseDao {
	
	protected SessionFactory sessionFactory;

	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	public <T> void save(T obj) {
		sessionFactory.getCurrentSession().saveOrUpdate(obj);
	}
	
	@Override
	public <T> void add(T obj) {
		sessionFactory.getCurrentSession().save(obj);
	}
	
	@Override
	public <T> void update(T obj) {
		sessionFactory.getCurrentSession().update(obj);
	}
	
	@Override
	public <T> void delete(T obj) {
		sessionFactory.getCurrentSession().delete(obj);
	}
	
	@Override
	public <T> T get(Class<T> clz, Serializable id) {
		return (T) sessionFactory.getCurrentSession().get(clz, id);
	}
	
	@Override
	public <T> List<T> find(DetachedCriteria criteria) {
		Criteria c = criteria.getExecutableCriteria(sessionFactory.getCurrentSession());
		return c.list();
	}
	
	@Override
	public PageResult find(DetachedCriteria criteria, int start, int pageSize) {
		PageResult page = new PageResult();
		Criteria c = criteria.getExecutableCriteria(sessionFactory.getCurrentSession());
		
		//总行数
		long rowCount = (Long) c.setProjection(Projections.rowCount()).uniqueResult();
		page.setRowCount(rowCount);
		
		//一页数据
		c.setProjection(null);
		c.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		List<?> list =  c.setFirstResult(start).setMaxResults(pageSize).list();
		page.setResult(list);
		
		return page;
	}
	
}
