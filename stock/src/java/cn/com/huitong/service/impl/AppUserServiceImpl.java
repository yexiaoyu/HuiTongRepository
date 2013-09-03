package cn.com.huitong.service.impl;

import java.util.List;

import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Grade;
import cn.com.huitong.service.AppUserService;

public class AppUserServiceImpl extends GenericDaoImpl<AppUser, Long> implements AppUserService{

	public List<Grade> findGradeAll() {
		super.getAll(AppUser.class);
		return null;
	}

	public Grade findGradeByGradeId(Long gradeId) {
		return null;
	}
//	public void saveAppUser(AppUser appUser){
//		this.save(appUser);
//	}
}
