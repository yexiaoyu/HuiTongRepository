package cn.com.huitong.service.impl;

import java.util.ArrayList;
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
		String hql = "FROM AppUser u WHERE u.isValid = 1 ";
		return this.findByHqlAndPage(hql, null, pb);
	}
	public List<AppUser> findAllValidUser(AppUser user,PagingBean pb){
		StringBuffer hql = new StringBuffer("FROM AppUser user WHERE user.isValid = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(user != null && !"".equals(user)){
			if(user.getUserName() != null && !"".equals(user.getUserName())){
				hql.append(" AND user.userName LIKE :userName ");
				param.put("userName", "%"+user.getUserName()+"%");
			}
			if(user.getGrade() != null && !"".equals(user.getGrade()) && user.getGrade().getGradeId() != null && !"".equals(user.getGrade().getGradeId())){
				hql.append(" AND user.grade.gradeId=:gradeId ");
				param.put("gradeId", user.getGrade().getGradeId());
			}
			if(user.getRealName() != null && !"".equals(user.getRealName())){
				hql.append(" AND user.realName LIKE :realName ");
				param.put("realName", "%"+user.getRealName()+"%");
			}
		}
		log.debug("SQL====" + hql);
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}
	public List<String> findAllUserName(){
		String hql = "SELECT userName FROM AppUser WHERE isValid = 1";
		List list = this.findByHQL(hql);
		List<String> userNames = new ArrayList<String>();
		if(list != null && !"".equals(list) && list.size()>0){
			for(Object obj : list){
				String name = (String)obj;
				userNames.add(name);
			}
		}
		log.debug(userNames);
		return userNames;
	}
}
