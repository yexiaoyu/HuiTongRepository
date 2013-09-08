package cn.com.huitong.action;

import java.util.List;

import javax.annotation.Resource;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.Stock;
import cn.com.huitong.service.StockService;

public class StockAction extends Struts2Action {
	private static final long serialVersionUID = 1L;

	@Resource
	private StockService stockService;
	
	private String nodeName;
	private Stock stock;
	private Long stockId;
	private List<Stock> stockList;
	
	public String operateStock(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("NodeName="+nodeName);
			result = nodeName;
			if(nodeName.equals("addStock")){
				this._addStock();
			}else if(nodeName.equals("queryStock") || nodeName.equals("queryStockEntry")){
				this._queryStock();
			}else if(nodeName.equals("deleteStock")){
				this._deleteStock();
			}
		}
		
		return result;
	}
	private void _addStock(){
		if(stock != null && !"".equals(stock)){
			stock.setIsValid("1");//添加时默认有效
			stockService.save(stock);
		}
		this._queryStock();
	}
	private void _queryStock(){
		logger.debug("queryStock----");
		PagingBean pb = this.getInitPagingBean();
		stockList = stockService.findAllStockValid(stock, pb);
	}

	private void _deleteStock(){
		if(stockId != null && !"".equals(stockId)){
			stockService.deleteByPK(stockId);
		}
		this._queryStock();
	}
	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}
	public List<Stock> getStockList() {
		return stockList;
	}
	public void setStockList(List<Stock> stockList) {
		this.stockList = stockList;
	}
	public Long getStockId() {
		return stockId;
	}
	public void setStockId(Long stockId) {
		this.stockId = stockId;
	}
	
}
