package cn.com.huitong.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;

import cn.com.huitong.core.common.Struts2Action;

@SuppressWarnings("serial")
public class AndroidAction extends Struts2Action{
	//callback=indexnews&enews=newsindex&start=0&length=5
	private String callback;//回调函数
	private String reqtype;//请求数据类型economic,inform,stock
	private String start;
	private String length;
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getReqtype() {
		return reqtype;
	}
	public void setReqtype(String reqtype) {
		this.reqtype = reqtype;
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
        //this.setResponseJson(map);
        StringBuffer resultReponse = new StringBuffer(callback);
        resultReponse.append("(");
        try {
        	resultReponse.append(JSONUtil.serialize(map));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		resultReponse.append(");");
		this._writeData(resultReponse.toString());
		return null;
	}
	private void _writeData(String s){
		try {
			getResponse().getWriter().write(s);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
