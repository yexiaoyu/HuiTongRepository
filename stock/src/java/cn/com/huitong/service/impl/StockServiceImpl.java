package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.Stock;
import cn.com.huitong.service.StockService;

public class StockServiceImpl extends GenericDaoImpl<Stock, Long> implements StockService {
	public List<Stock> findAllStockValid(PagingBean pb){
		String hql = "FROM Stock s WHERE s.isValid = 1 ";
		return this.findByHqlAndPage(hql, null, pb);
	}
	public List<Stock> findAllStockValid(Stock stock, PagingBean pb){
		StringBuffer hql = new StringBuffer("FROM Stock s WHERE 1 = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(stock != null && !"".equals(stock)){
			if(stock.getStockCode() != null && !"".equals(stock.getStockCode())){
				hql.append(" AND s.stockCode LIKE :stockCode ");
				param.put("stockCode", stock.getStockCode());
			}
			if(stock.getStockName() != null && !"".equals(stock.getStockName())){
				hql.append(" AND s.stockName LIKE :stockName ");
				param.put("stockName", stock.getStockName());
			}
			if(stock.getIsValid() != null && !"".equals(stock.getIsValid())){
				hql.append(" AND s.isValid=:isValid ");
				param.put("isValid", stock.getIsValid());
			}
		}
		log.debug("SQL====" + hql);
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}
}
