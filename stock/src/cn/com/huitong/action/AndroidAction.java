package cn.com.huitong.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.Struts2Action;

@SuppressWarnings("serial")
public class AndroidAction extends Struts2Action{
	//callback=indexnews&enews=newsindex&start=0&length=5
	private String callback;
	private String enews;
	private String start;
	private String length;
	 public Map<String, Object> responseJson; 
	
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getEnews() {
		return enews;
	}
	public void setEnews(String enews) {
		this.enews = enews;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getLength() {
		return length;
	}
	public void setLength(String length) {
		this.length = length;
	}
	
	public Map<String, Object> getResponseJson() {
		return responseJson;
	}
	public void setResponseJson(Map<String, Object> responseJson) {
		this.responseJson = responseJson;
	}
	public String index(){
		Map<String, Object> map = new HashMap<String, Object>();   
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();   
        for(int i=0;i<3;i++){   
            Map<String, Object> m = new HashMap<String, Object>();   
            m.put("id", i);   
            m.put("name", "Mic"+i);   
            list.add(m);   
        }   
        map.put("rows", list);   
        map.put("totalCont", 3);   
        this.setResponseJson(map);
		return SUCCESS;
	}
}
