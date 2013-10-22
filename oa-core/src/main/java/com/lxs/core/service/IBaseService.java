package com.lxs.core.service;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.lxs.core.common.page.PageResult;

public interface IBaseService {

	/**
	 * 添加修改
	 * 为方法声明泛型 
	 *    比如下面的声明public <T> void save(T obj) 表示add方法操作的对象类型是T
	 *    T类型到底是什么类型对象，是由方法调用的时候决定
	 *    dao.add(Dept) T类型Dept
	 *    dao.add(User) T类型User
	 * @param obj 添加的对象
	 */
	public abstract <T> void save(T obj);

	/**
	 * 添加方法
	 * @param obj
	 */
	public abstract <T> void add(T obj);

	/**
	 * 修改方法
	 * @param obj
	 */
	public abstract <T> void update(T obj);

	/**
	 * 删除方法
	 * @param obj
	 */
	public abstract <T> void delete(T obj);

	/**
	 * 加载方法
	 * @param clz
	 * @param id
	 * @return
	 */
	public abstract <T> T get(Class<T> clz, Serializable id);

	/**
	 * 标准查询
	 * @param criteria
	 */
	public abstract <T> List<T> find(DetachedCriteria criteria);

	/**
	 * 分页查询
	 * @param dept 封装了查询条件的对象
	 * @param start 起始的下标
	 * @param pageSize 每页行数
	 * @return pageResult 里面有一页数据，和总行数
	 */
	public abstract PageResult find(DetachedCriteria criteria, int start,
			int pageSize);

}