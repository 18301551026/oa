package com.lxs.oa.message.dao;

import java.util.List;

import com.lxs.oa.message.domain.ShareFileTree;

public interface IShareFileTreeDao {
	/**
	 * 查询所有根菜单
	 * @return
	 */
	public abstract List<ShareFileTree> findRootMenu();
}
