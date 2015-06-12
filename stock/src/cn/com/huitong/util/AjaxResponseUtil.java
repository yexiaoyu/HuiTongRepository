package cn.com.huitong.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author quyf
 * 
 * @Date 2013-9-22
 */
public class AjaxResponseUtil {
	protected static Logger log = LoggerFactory.getLogger( AjaxResponseUtil.class );
	/**
	 * 一般用于返回jsonp的json消息
	 * @param response
	 * @param jsonCallback
	 * @param responseData
	 */
	public static void jsonCallback(HttpServletResponse response,String jsonCallback, Map<String, Object> responseData){
		String msg = createJson(responseData);
		msg = jsonCallback + "(" + msg + ")";
		
		// 写入response
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(msg);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void returnData(HttpServletRequest request, HttpServletResponse response, String format, String jsonCallBackName,Map<String, Object> responseData) {
		String msg = null;
		if (format!=null && format.equals("json")) {
			msg = createJson(responseData);
			if(!StockUtil.isEmpty(jsonCallBackName))
				msg = jsonCallBackName + "(" + msg + ")";
		} else if(format!=null && format.equals("xml")){
			msg = createXml(responseData);
		} else if(format!=null && format.equals("tbxml")){
			msg = createTbXml(responseData);
		} else{//默认
			msg = createJson(responseData);
		}
		
		//打印标准日志
		//日志格式
		//时间	调用接口名	接口参数	返回结果
		StringBuilder stbParam = new StringBuilder();
		@SuppressWarnings("unchecked")
		Map<String, String> rnames=  (HashMap<String, String>) request.getAttribute("requestData");
		if(rnames!=null){
			Iterator<?> iter = rnames.entrySet().iterator();
			while ( iter.hasNext()) {
			        String thisName=iter.next().toString();
			        if(thisName.contains("paras"))continue;
			        if(thisName.contains("sign"))continue;
			        stbParam.append(thisName+";");
			}
		}
		stbParam.append("connectIps="+StockUtil.getConnectIps(request)+";");
		String methodName = request.getRequestURI();
		//打印标准日志
		//CommonConstants.STANDARDLOG.info("method:["+methodName+"]\t request:["+stbParam.toString()+"]\t result:"+responseData.get("result")+ "\t msg:"+responseData.get("msg"));
		
		String retMsg = (String)responseData.get("msg");
		retMsg = StockUtil.replaceTabAndLine(retMsg);		
		
		String responseStr = msg.replaceAll("\r"," ").replaceAll("\n", " ").replaceAll("\t", " ").replaceAll("},", "},\n");
		StringBuffer logStrBuff = new StringBuffer();
		logStrBuff.append("method:["+methodName+"]  request:["+stbParam.toString()+"]  result:"+responseData.get("result")+ "  msg:"+retMsg);
		logStrBuff.append(" 返回结果详细-:"+responseStr);
		log.info(logStrBuff.toString());

		returnData(request, response, msg);
	}
	
	/**
	 * 根据 format参数，返回不同格式的消息
	 * @param request 打印日志和返回Json 或 xml
	 * @param response
	 * @param responseData
	 * @param format:json,xml
	 */
	public static void returnData(HttpServletRequest request, HttpServletResponse response, String format, Map<String, Object> responseData) {
		returnData(request, response, format, "", responseData);
	}
	/**
	 * 返回Map格式的json消息
	 * @param response
	 * @param returnData
	 */
	public static void returnData(HttpServletRequest request, HttpServletResponse response, Map<String,Object> returnData){
		returnData(request, response, "json", returnData);
	}
	
	public static void returnData(HttpServletRequest request, HttpServletResponse response, String msg) {
		// 写入response
		try {
			response.setContentType("text/html; charset=UTF-8");
			if(request!=null) {
				response.setHeader("Set-Cookie", "JSESSIONID="+request.getSession().getId()+";secure;HttpOnly");
			} else {				
				response.setHeader("Set-Cookie", "secure;HttpOnly");
			}
			response.getWriter().write(msg);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public  static void returnData(HttpServletResponse response, String msg) {
		returnData(null, response, msg);
	}
	
	private static String createXml(Map<String, Object> responseData){
		StringBuilder sb = new StringBuilder();

		sb.append("<data>");
		for (String key : responseData.keySet()) {
			sb.append("<").append(key).append(">");
			sb.append(responseData.get(key));
			sb.append("</").append(key).append(">");
		}
		sb.append("</data>");

		Document doc = null;
		try {
			doc = DocumentHelper.parseText(sb.toString());
		} catch (DocumentException e) {
			return null;
		}
		return doc.asXML();
	}

	private static String createTbXml(Map<String, Object> responseData){
		StringBuffer sb = new StringBuffer();
	    sb.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
	    sb.append("<response>");
		for (String key : responseData.keySet()) {
			sb.append("<").append(key).append(">");
			sb.append(responseData.get(key));
			sb.append("</").append(key).append(">");
		}
		sb.append("</response>");

		Document doc = null;
		try {
			doc = DocumentHelper.parseText(sb.toString());
		} catch (DocumentException e) {
			e.printStackTrace();
			return null;
		}
		String msg = doc.asXML();
		return msg;
	}
	
	public static String createJson(Map<String, Object> responseData){
	    return JSONArray.fromObject(responseData).toString();
//		return JsonEncoder.encode(responseData);
	}
	
}
