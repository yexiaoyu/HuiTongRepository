package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.AppUser;

public interface AppUserService extends GenericDao<AppUser, Long>{
	//public void saveAppUser(AppUser appUser);
	public List<AppUser> findAllValidUser(PagingBean pb);
	public List<AppUser> findAllValidUser(AppUser user,PagingBean pb);
}
