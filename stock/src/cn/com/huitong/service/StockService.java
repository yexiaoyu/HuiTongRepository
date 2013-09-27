package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.Stock;

public interface StockService extends GenericDao<Stock, Long>{
	public List<Stock> findAllStockValid(PagingBean pb);
	public List<Stock> findAllStockValid(Stock stock, PagingBean pb);
}
