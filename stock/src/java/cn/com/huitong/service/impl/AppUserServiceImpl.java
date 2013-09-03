package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Grade;
import cn.com.huitong.service.AppUserService;

public class AppUserServiceImpl extends GenericDaoImpl<AppUser, Long> implements AppUserService{

//	public void saveAppUser(AppUser appUser){
//		this.save(appUser);
//	}
	public List<AppUser> findAllValidUser(PagingBean pb){
		String hql = "FROM AppUser WHERE isValid = 1";
		return this.findByHqlAndPage(hql, null, pb);
	}
	public List<AppUser> findAllValidUser(AppUser user,PagingBean pb){
		StringBuffer hql = new StringBuffer("FROM AppUser WHERE isValid = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(user != null && !"".equals(user)){
			if(user.getUserName() != null && !"".equals(user.getUserName())){
				hql.append(" AND userName=:userName ");
				param.put("userName", user.getUserName());
			}
			if(user.getGrade() != null && !"".equals(user.getGrade()) && user.getGrade().getGradeId() != null && !"".equals(user.getGrade().getGradeId())){
				hql.append(" AND grade.gradeId=:gradeId ");
				param.put("gradeId", user.getGrade().getGradeId());
			}
			if(user.getRealName() != null && !"".equals(user.getRealName())){
				hql.append(" AND realName=:realName ");
				param.put("realName", user.getRealName());
			}
		}
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}
}
