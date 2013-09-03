package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.Grade;

public interface GradeService extends GenericDao<Grade, Long>{
	public List<Grade> findGradeAll();
	
	public Grade findGradeByGradeId(Long gradeId);
}
