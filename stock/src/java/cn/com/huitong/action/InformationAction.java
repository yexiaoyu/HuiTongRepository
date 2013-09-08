package cn.com.huitong.action;

import cn.com.huitong.core.common.Struts2Action;

public class InformationAction extends Struts2Action{
	private static final long serialVersionUID = -5169176774978832602L;
	
	private String nodeName;
	public String operateInformation(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			result = nodeName;
			if(nodeName.equals("addInformation")){
				
			}
		}
		
		return result;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	
	
	
	
}
