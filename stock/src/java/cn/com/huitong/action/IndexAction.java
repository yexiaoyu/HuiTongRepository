package cn.com.huitong.action;

import cn.com.huitong.core.common.Struts2Action;

@SuppressWarnings("serial")
public class IndexAction extends Struts2Action{
	/**
	 * 前台入口
	 * @return
	 */
	public String foreIndex(){
		return SUCCESS;
	}
	
	//background  start
	/**
	 * 后台入口
	 */
	public String backGroundIndex(){
		return SUCCESS;
	}
	//background  end
}
