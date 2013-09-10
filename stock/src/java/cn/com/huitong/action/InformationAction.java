package cn.com.huitong.action;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import nl.captcha.Captcha;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.Grade;
import cn.com.huitong.model.Information;
import cn.com.huitong.model.Stock;
import cn.com.huitong.service.GradeService;
import cn.com.huitong.service.InformationService;
import cn.com.huitong.service.StockService;
import cn.com.huitong.util.BeanUtil;

public class InformationAction extends Struts2Action{
	private static final long serialVersionUID = -5169176774978832602L;
	@Resource
	private InformationService informationService;
	private String nodeName;
	private Information information;
	private Long informId;
	private List<Information> informList;
	private String checkCode;
	
	@Resource(name="gradeService")
	private GradeService gradeService;
	private List<Grade> gradeList;
	
	@Resource
	private StockService stockService;
	private List<Stock> stockList;
	
	public String operateInformation(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("addInformation")){
				this._addStock();
			}else if(nodeName.equals("queryInformation") || nodeName.equals("queryInformationEntry")){
				this._queryInformation();
			}else if(nodeName.equals("deleteInformation")){
				this._deleteInformation();
			}else if(nodeName.equals("updateInformationEntry")){
				this._updateInformationEntry();
			}else if(nodeName.equals("updateInformation")){
				this._updateInformation();
			}else if(nodeName.equals("detailInformation")){
				this._detailInformation();
			}
		}
		gradeList = gradeService.findGradeAll();
		PagingBean pb = this.getInitPagingBean();
		stockList = stockService.findAllStockValid(pb);
		return result;
	}
	/**
	 * 前台访问内参的入口
	 * @return
	 */
	public String operateInform(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("informIndex") || nodeName.equals("queryInformPage")){
				this._informIndex();
			}
		}
		return result;
	}
	
	private void _informIndex() {
		logger.debug("_informIndex--------");
		this._queryInformation();
	}
	private void _detailInformation() {
		logger.debug("_detailInformation--------" + informId);
		information = informationService.get(informId);
	}
	private void _addStock() {
		logger.debug("_addStock----");
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(information != null && !"".equals(information)){
				information.setInputTime(new Date());
				information.setGrade(gradeService.get(information.getGrade().getGradeId()));
				information.setStock(stockService.get(information.getStock().getStockId()));
				informationService.save(information);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryInformation();
	}
	private void _updateInformation() {
		logger.debug("_updateInformation--------");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(information != null && !"".equals(information)){
				Information oldInform = informationService.get(information.getInformId());
				try {
					BeanUtil.copyNotNullProperties(oldInform, information);
					oldInform.setGrade(gradeService.get(oldInform.getGrade().getGradeId()));
					oldInform.setStock(stockService.get(oldInform.getStock().getStockId()));
					informationService.save(oldInform);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryInformation();
	}
	private void _updateInformationEntry() {
		logger.debug("_updateInformationEntry--------" + informId);
		information = informationService.get(informId);
	}
	private void _deleteInformation() {
		logger.debug("_deleteInformation--------");
		if(informId != null && !"".equals(informId)){
			informationService.deleteByPK(informId);
		}
		this._queryInformation();
	}
	private void _queryInformation() {
		logger.debug("_queryInformation--------");
		PagingBean pb = this.getInitPagingBean();
		informList = informationService.findAllInformationValid(information, pb);
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public Information getInformation() {
		return information;
	}
	public void setInformation(Information information) {
		this.information = information;
	}
	public Long getInformId() {
		return informId;
	}
	public void setInformId(Long informId) {
		this.informId = informId;
	}
	public List<Information> getInformList() {
		return informList;
	}
	public void setInformList(List<Information> informList) {
		this.informList = informList;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public List<Grade> getGradeList() {
		return gradeList;
	}
	public void setGradeList(List<Grade> gradeList) {
		this.gradeList = gradeList;
	}
	public List<Stock> getStockList() {
		return stockList;
	}
	public void setStockList(List<Stock> stockList) {
		this.stockList = stockList;
	}
}
