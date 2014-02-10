package cn.com.huitong.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.News;
import cn.com.huitong.service.NewsService;

@SuppressWarnings("serial")
public class AndroidAction extends Struts2Action{
	//callback=onLineJsonp&reqtype=82&start=0&length=10
	private String callback;//回调函数
	private String reqtype;//请求数据类型82,83...
	private Integer start;
	private Integer length;
	
	private List<News> newsList;
	@Resource
	private NewsService newsService;
	
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
	
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public String index(){
		if(reqtype != null && !"".equals(reqtype)){
			PagingBean pb = this.getInitPagingBean();
			start = start/length + 1;
			pb.setStart(start);
			pb.setPageSize(length);
			News news = new News();
			news.setType(reqtype);
			newsList = newsService.findNewsList(news, pb);
		}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    for(News news : newsList){   
	    	Map<String, Object> map = new HashMap<String, Object>();   
	    	map.put("id", news.getId());
	    	map.put("title", news.getTitle());
	    	map.put("shortContent", news.getShortContent());
	    	String content = news.getContent();
	    	content = content.replace("\"", "'");
	    	map.put("content", content);
	    	map.put("modifyTime", sdf.format(news.getModifyTime()));
	    	map.put("type", news.getType());
	    	list.add(map);
	    }   
		StringBuffer resultReponse = new StringBuffer(callback+"({\"articles\":");
        try {
        	resultReponse.append(JSONUtil.serialize(list));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		resultReponse.append("});");
		System.out.println("返回的数据："+resultReponse);
		this._writeData(resultReponse.toString());
		return null;
		
//		Map<String, Object> map = new HashMap<String, Object>();   
//        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();   
//        for(int i=0;i<3;i++){   
//            Map<String, Object> m = new HashMap<String, Object>();   
//            m.put("id", i);   
//            m.put("name", "Mic"+i);   
//            list.add(m);   
//        }   
//        map.put("rows", list);   
//        map.put("totalCont", 3);
        //this.setResponseJson(map);
      
	}
	private void _writeData(String s){
		try {
			HttpServletResponse response = getResponse();
			response.setHeader("Content-type", "text/html;charset=UTF-8");
			OutputStream ps = response.getOutputStream();  
	        //这句话的意思，使得放入流的数据是utf8格式  
	        ps.write(s.getBytes("UTF-8")); 
	        ps.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
