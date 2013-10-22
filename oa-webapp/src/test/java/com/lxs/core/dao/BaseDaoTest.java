package com.lxs.core.dao;

import static org.junit.Assert.*;

import org.hibernate.criterion.DetachedCriteria;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;

import com.lxs.core.dao.impl.BaseDaoImpl;
import com.lxs.security.domain.Menu;

public class BaseDaoTest {
	
	private IBaseDao baseDao;
	
	public BaseDaoTest() {
		ApplicationContext ac = new ClassPathXmlApplicationContext(new String[]{"spring/applicationContext.xml","spring/activiti-context.xml"});
		baseDao = ac.getBean(BaseDaoImpl.class);
	}

}
