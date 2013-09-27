package cn.com.huitong.action;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import nl.captcha.Captcha;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.EconomicCalenda;
import cn.com.huitong.model.Stock;
import cn.com.huitong.service.EconomicService;
import cn.com.huitong.service.StockService;
import cn.com.huitong.util.BeanUtil;

@SuppressWarnings("serial")
public class EconomicAction extends Struts2Action{
	private String nodeName;
	private String checkCode;
	private EconomicCalenda economic;
	private Long economicId;
	private List<EconomicCalenda> economicList;
	@Resource
	private EconomicService economicService;
	@Resource
	private StockService stockService;
	private List<Stock> stockList;
	
	/**
	 * 后台访问入口
	 * @return
	 */
	public String operateEconomic(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("addEconomic")){
				this._addStock();
			}else if(nodeName.equals("queryEconomic") || nodeName.equals("queryEconomicEntry") 
					|| nodeName.equals("queryEconomicPage") || nodeName.equals("economicIndex")){
				this._queryEconomic();
			}else if(nodeName.equals("deleteEconomic")){
				this._deleteEconomic();
			}else if(nodeName.equals("updateEconomicEntry")){
				this._updateEconomicEntry();
			}else if(nodeName.equals("updateEconomic")){
				this._updateEconomic();
			}else if(nodeName.equals("detailEconomic")){
				this._detailEconomic();
			}
		}
		//gradeList = gradeService.findGradeAll();
		PagingBean pb = this.getInitPagingBean();
		stockList = stockService.findAllStockValid(pb);
		return result;
	}
	/**
	 * 前台访问财经的入口
	 * @return
	 
	public String operateInform(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("informIndex") || nodeName.equals("queryEconomicPage")){
				this._informIndex();
			}
		}
		return result;
	}
	
	private void _informIndex() {
		logger.debug("_informIndex--------");
		this._queryEconomic();
	}*/
	private void _detailEconomic() {
		logger.debug("_detailEconomic--------" + economicId);
		economic = economicService.get(economicId);
	}
	private void _addStock() {
		logger.debug("_addStock----");
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(economic != null && !"".equals(economic)){
//				economic.setInputTime(new Date());
//				Economic.setGrade(gradeService.get(Economic.getGrade().getGradeId()));
				economic.setStock(stockService.get(economic.getStock().getStockId()));
				economicService.save(economic);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryEconomic();
	}
	private void _updateEconomic() {
		logger.debug("_updateEconomic--------");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(economic != null && !"".equals(economic)){
				EconomicCalenda oldInform = economicService.get(economic.getEconomicID());
				try {
					BeanUtil.copyNotNullProperties(oldInform, economic);
//					oldInform.setGrade(gradeService.get(oldInform.getGrade().getGradeId()));
					oldInform.setStock(stockService.get(oldInform.getStock().getStockId()));
					economicService.save(oldInform);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryEconomic();
	}
	private void _updateEconomicEntry() {
		logger.debug("_updateEconomicEntry--------" + economicId);
		economic = economicService.get(economicId);
	}
	private void _deleteEconomic() {
		logger.debug("_deleteEconomic--------");
		if(economicId != null && !"".equals(economicId)){
			economicService.deleteByPK(economicId);
		}
		this._queryEconomic();
	}
	private void _queryEconomic() {
		logger.debug("_queryEconomic--------");
		PagingBean pb = this.getInitPagingBean();
		economicList = economicService.findAllEconomicValid(economic, pb);
	}
	
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public EconomicCalenda getEconomic() {
		return economic;
	}
	public void setEconomic(EconomicCalenda economic) {
		this.economic = economic;
	}
	public Long getEconomicId() {
		return economicId;
	}
	public void setEconomicId(Long economicId) {
		this.economicId = economicId;
	}
	public List<Stock> getStockList() {
		return stockList;
	}
	public void setStockList(List<Stock> stockList) {
		this.stockList = stockList;
	}
	public List<EconomicCalenda> getEconomicList() {
		return economicList;
	}
	public void setEconomicList(List<EconomicCalenda> economicList) {
		this.economicList = economicList;
	}
	
}
