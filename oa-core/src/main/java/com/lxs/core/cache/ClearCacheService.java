package com.lxs.core.cache;

import javax.annotation.Resource;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;


@Component
@Aspect
public class ClearCacheService {
	
	@Resource
	private SessionFactory sessionFactory;
	
	@Before("@annotation(com.lxs.core.cache.ClearCache)")
	public void cleanSecondCache() {
		sessionFactory.getCache().evictCollectionRegions();
		sessionFactory.getCache().evictDefaultQueryRegion();
		sessionFactory.getCache().evictQueryRegions();
		sessionFactory.getCache().evictEntityRegions();
	}

}
