package com.lxs.core.action;

import java.lang.reflect.Method;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;

import com.lxs.core.common.BeanUtil;
import com.lxs.core.common.GenericUtil;
import com.lxs.core.common.page.PageAction;
import com.lxs.core.common.page.PageResult;
import com.lxs.core.service.IBaseService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public abstract class BaseAction<T> extends PageAction implements ModelDriven<T> {
	
	public static final String ID_GET_METHOD = "getId";
	
	@Resource
	protected IBaseService baseService;
	
	protected T model;
	protected Class<T> modelClass;
	
	protected Long[] ids; 
	
	public BaseAction() {
		this.modelClass = GenericUtil.getSuperGenericClass(this.getClass());
	}

	@Override
	public T getModel() {
		if (null == model) {
			try {
				model = (T) modelClass.newInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;
	}
	
	/**
	 * 模板方法：在跳到添加页面执行之前执行
	 */
	public void beforToAdd() {
		
	}
	
	/**
	 * 模板方法: 在加载前执行
	 */
	public void beforToUpdate() {
		
	}
	
	/**
	 * 模板方法：在加载之后执行
	 * @param entity
	 */
	public void afterToUpdate(T entity) {
		
	}
	
	/**
	 * 模板方法： 在添加或修改之前执行
	 * @param model
	 */
	public void beforeSave(T model) {
		
	}
	
	/**
	 * 模板方法
	 * 在查询执行之前执行，一般用来组织查询条件
	 * 这个方法在子类重写之后，用来在子类组织查询条件
	 * @param criteria
	 */
	public void beforFind(DetachedCriteria criteria) {
		
	}
	
	
	/**
	 * 跳到添加页面
	 * @return
	 */
	public String toAdd() {
		beforToAdd();
		return ADD;
	}
	
	/**
	 * 加载
	 * @return
	 */
	public String toUpdate() throws Exception {
		//modelClass Dept,Job ---> getId() ---> Long id值
		//DeptAction extends BaseAction<Dept> ----> modelClass == Dept
		//得到dept getId()方法
		Method idGetter = BeanUtil.getMethod(modelClass, ID_GET_METHOD);
		//掉用getId方法得到id
		Long id = (Long) idGetter.invoke(model);
		beforToUpdate();
		T entity = baseService.get(modelClass, id);
		afterToUpdate(entity);
		ActionContext.getContext().getValueStack().push(entity);
		return UPDATE;
	}	
	
	/**
	 * 增加，修改
	 */
	public String save() throws Exception {
		beforeSave(model);
		//得到主键的值
		Long id = (Long) BeanUtil.getMethod(modelClass, ID_GET_METHOD).invoke(model);
		
		T entity = null;
		if (null == id) {
			entity = modelClass.newInstance();
		} else {
			entity = baseService.get(modelClass, id);
		}
		BeanUtil.copy(model, entity);
		
		baseService.save(entity);
		afterSave(entity);
		return LIST_ACTION; 
	}
	
	public void afterSave(T model){
		
	}
	public void beforeDelete(T model){
		
	}
	/**
	 * 删除
	 */
	public String delete() {
		for (Long id : ids) {
			T entity = baseService.get(modelClass, id);
			beforeDelete(entity);
			baseService.delete(entity);
		}
		return LIST_ACTION; 
	}
	
	/**
	 * 分页查询
	 * @return
	 */
	public String findPage() {
		DetachedCriteria criteria = DetachedCriteria.forClass(modelClass);
		
		beforFind(criteria);
		PageResult page = baseService.find(criteria, start, pageSize);
		
		ActionContext.getContext().put(PAGE, page);
		return LIST;
	}
	
	/**
	 * 标准查询
	 * @return
	 */
	public String find() {
		DetachedCriteria criteria = DetachedCriteria.forClass(modelClass);
		
		beforFind(criteria);
		List<T> list = baseService.find(criteria);
		
		ActionContext.getContext().put(LIST, list);
		return LIST;
	}
	
	public void setIds(Long[] ids) {
		this.ids = ids;
	}


}
