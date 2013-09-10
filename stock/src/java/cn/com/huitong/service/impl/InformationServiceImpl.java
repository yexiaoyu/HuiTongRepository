package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.Information;
import cn.com.huitong.service.InformationService;

public class InformationServiceImpl extends GenericDaoImpl<Information, Long> implements InformationService {
	public List<Information> findAllInformationValid(Information information, PagingBean pb){
		StringBuffer hql = new StringBuffer("FROM Information s WHERE 1 = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(information != null && !"".equals(information)){
			if(information.getTitle() != null && !"".equals(information.getTitle())){
				hql.append(" AND s.title LIKE :title ");
				param.put("title", "%"+information.getTitle()+"%");
			}
			if(information.getContent() != null && !"".equals(information.getContent())){
				hql.append(" AND s.content LIKE :content ");
				param.put("content", "%"+information.getContent()+"%");
			}
			if(information.getStock() != null && !"".equals(information.getStock()) 
					&& information.getStock().getStockId() != null && !"".equals(information.getStock().getStockId())){
				hql.append(" AND s.stock.stockId=:stockId ");
				param.put("stockId", information.getStock().getStockId());
			}
			if(information.getGrade() != null && !"".equals(information.getGrade()) 
					&& information.getGrade().getGradeId() != null && !"".equals(information.getGrade().getGradeId())){
				hql.append(" AND s.grade.gradeId=:gradeId ");
				param.put("gradeId", information.getGrade().getGradeId());
			}
			if(information.getIsValid() != null && !"".equals(information.getIsValid())){
				hql.append(" AND s.isValid=:isValid ");
				param.put("isValid", information.getIsValid());
			}
		}
		hql.append("ORDER BY s.informId DESC");
		log.debug("SQL====" + hql);
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}
}
