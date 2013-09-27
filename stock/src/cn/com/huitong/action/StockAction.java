package cn.com.huitong.action;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import nl.captcha.Captcha;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Stock;
import cn.com.huitong.service.StockService;
import cn.com.huitong.util.BeanUtil;

public class StockAction extends Struts2Action {
	private static final long serialVersionUID = 1L;

	@Resource
	private StockService stockService;
	
	private String nodeName;
	private Stock stock;
	private Long stockId;
	private List<Stock> stockList;
	private String checkCode;
	
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
			}else if(nodeName.equals("updateStockEntry")){
				this._updateStockEntry();
			}else if(nodeName.equals("updateStock")){
				this._updateStock();
			}
		}
		
		return result;
	}
	private void _addStock(){
		logger.debug("_addStock----");
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(stock != null && !"".equals(stock)){
				//stock.setIsValid("1");//添加时默认有效
				stockService.save(stock);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryStock();
	}
	private void _queryStock(){
		logger.debug("queryStock----");
		PagingBean pb = this.getInitPagingBean();
		stockList = stockService.findAllStockValid(stock, pb);
	}

	private void _deleteStock(){
		logger.debug("_deleteStock----");
		if(stockId != null && !"".equals(stockId)){
			stockService.deleteByPK(stockId);
		}
		this._queryStock();
	}
	
	private String _updateStockEntry(){
		logger.debug("updateStockEntry........." + stockId);
		stock = stockService.get(stockId);
		return SUCCESS;
	}
	
	private String _updateStock(){
		logger.debug("updateStock.........");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(stock != null && !"".equals(stock)){
				Stock oldStock = stockService.get(stock.getStockId());
				try {
					BeanUtil.copyNotNullProperties(oldStock, stock);
					stockService.save(oldStock);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryStock();
		return SUCCESS;
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
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	
}
