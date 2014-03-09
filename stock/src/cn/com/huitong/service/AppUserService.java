package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.AppUser;

public interface AppUserService extends GenericDao<AppUser, Long>{
	//public void saveAppUser(AppUser appUser);
	/**
	 * 分页查询所有
	 */
	public List<AppUser> findAllValidUser(PagingBean pb);
	/**
	 * 按传入条件分页查询
	 * @param user
	 * @param pb
	 * @return
	 */
	public List<AppUser> findAllValidUser(AppUser user,PagingBean pb);
	/***
	 * 查询所有的用户名
	 * @return
	 */
	public List<String> findAllUserName();
	
	public AppUser findAppUserByUserName(String userName);
	public AppUser login(String username, String password);
	public AppUser login(Long userid, String password);
}
