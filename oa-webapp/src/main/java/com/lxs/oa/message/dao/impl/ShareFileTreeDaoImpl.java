package com.lxs.oa.message.dao.impl;
import java.util.List;
import javax.annotation.Resource;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import com.lxs.oa.message.dao.IShareFileTreeDao;
import com.lxs.oa.message.domain.ShareFileTree;
@Repository
public class ShareFileTreeDaoImpl implements IShareFileTreeDao {

	@Resource
	private SessionFactory sessionFactory;

	@Override
	public List<ShareFileTree> findRootMenu() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				ShareFileTree.class);
		criteria.add(Restrictions.isNull("parent"));
		//criteria.setCacheable(true);
		List<ShareFileTree> list = criteria.list();

		return list;
	}
}
