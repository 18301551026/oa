package com.lxs.core.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Service;

import com.lxs.core.common.page.PageResult;
import com.lxs.core.dao.IBaseDao;
import com.lxs.core.service.IBaseService;

@Service
public class BaseServiceImpl implements IBaseService {

	@Resource
	private IBaseDao baseDao;

	@Override
	public <T> void save(T obj) {
		baseDao.save(obj);
	}

	@Override
	public <T> void add(T obj) {
		baseDao.add(obj);
	}

	@Override
	public <T> void update(T obj) {
		baseDao.update(obj);
	}

	@Override
	public <T> void delete(T obj) {
		baseDao.delete(obj);
	}

	@Override
	public <T> T get(Class<T> clz, Serializable id) {
		return baseDao.get(clz, id);
	}

	@Override
	public <T> List<T> find(DetachedCriteria criteria) {
		return baseDao.find(criteria);
	}

	@Override
	public PageResult find(DetachedCriteria criteria, int start, int pageSize) {
		return baseDao.find(criteria, start, pageSize);
	}

}
