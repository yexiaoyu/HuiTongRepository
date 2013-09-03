package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Grade;
import cn.com.huitong.service.GradeService;

public class GradeServiceImpl  extends GenericDaoImpl<Grade, Long> implements GradeService {

	public List<Grade> findGradeAll() {
		return super.getAll(Grade.class);
	}

	public Grade findGradeByGradeId(Long gradeId) {
		String hql = "FROM Grade WHERE gradeId=:gradeId";
		Map<String, Object> parm = new HashMap<String, Object>();
		parm.put(":gradeId", gradeId);
		List<Grade> grades = super.findByHQL(hql, parm);
		if(grades != null && !"".equals(grades) && grades.size()>0){
			return grades.get(0);
		}else{
			return null;
		}
	}

}
