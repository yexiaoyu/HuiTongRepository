package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.EconomicCalenda;
import cn.com.huitong.service.EconomicService;

public class EconomicServiceImpl extends GenericDaoImpl<EconomicCalenda, Long> implements EconomicService{

	public List<EconomicCalenda> findAllEconomicValid(EconomicCalenda economic,PagingBean pb) {
		StringBuffer hql = new StringBuffer("FROM EconomicCalenda s WHERE 1 = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(economic != null && !"".equals(economic)){
			if(economic.getIsEvent() != null && !"".equals(economic.getIsEvent())){
				hql.append(" AND s.isEvent=:isEvent ");
				param.put("isEvent",economic.getIsEvent());
			}
			if(economic.getTime() != null && !"".equals(economic.getTime())){
				hql.append(" AND s.time >= :time ");
				param.put("time", economic.getTime());
			}
			if(economic.getStock() != null && !"".equals(economic.getStock()) 
					&& economic.getStock().getStockId() != null && !"".equals(economic.getStock().getStockId())){
				hql.append(" AND s.stock.stockId=:stockId ");
				param.put("stockId", economic.getStock().getStockId());
			}
			if(economic.getIsValid() != null && !"".equals(economic.getIsValid())){
				hql.append(" AND s.isValid=:isValid ");
				param.put("isValid", economic.getIsValid());
			}
			if(economic.getIsInland() != null && !"".equals(economic.getIsInland())){
				hql.append(" AND s.isInland=:isInland ");
				param.put("isInland", economic.getIsInland());
			}
			if(economic.getMeetingType() != null && !"".equals(economic.getMeetingType())){
				hql.append(" AND s.meetingType=:meetingType ");
				param.put("meetingType", economic.getMeetingType());
			}
			if(economic.getImpactType() != null && !"".equals(economic.getImpactType())){
				hql.append(" AND s.impactType=:impactType ");
				param.put("impactType", economic.getImpactType());
			}
			if(economic.getTopic() != null && !"".equals(economic.getTopic())){
				hql.append(" AND s.topic LIKE :topic ");
				param.put("topic", "%"+economic.getTopic()+"%");
			}
			if(economic.getContent() != null && !"".equals(economic.getContent())){
				hql.append(" AND s.content LIKE :content ");
				param.put("content", "%"+economic.getContent()+"%");
			}
		}
		hql.append("ORDER BY s.economicID DESC");
		log.debug("SQL====" + hql);
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}

}
