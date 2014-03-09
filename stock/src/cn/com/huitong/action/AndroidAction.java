package cn.com.huitong.action;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.News;
import cn.com.huitong.model.Version;
import cn.com.huitong.service.AppUserService;
import cn.com.huitong.service.GradeService;
import cn.com.huitong.service.NewsService;
import cn.com.huitong.service.VersionService;
import cn.com.huitong.util.AjaxResponseUtil;

@SuppressWarnings("serial")
public class AndroidAction extends Struts2Action{
	//callback=onLineJsonp&reqtype=82&start=0&length=10
	private String callback;//回调函数
	private String reqtype;//请求数据类型82,83...
	private Integer start;
	private Integer length;
	
	//升级版本
	private Float version;
	private Integer clientType;
	
	//android登录
	private String username;
	private String password;
	//注册
	private String phone;
	private String email;
	private Long userid;
	private List<News> newsList;
	@Resource
	private NewsService newsService;
	@Resource
	private VersionService versionService;
	@Resource
	private AppUserService appUserService;
	@Resource(name="gradeService")
	private GradeService gradeService;
	
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
	public Float getVersion() {
		return version;
	}
	public void setVersion(Float version) {
		this.version = version;
	}
	public Integer getClientType() {
		return clientType;
	}
	public void setClientType(Integer clientType) {
		this.clientType = clientType;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public Long getUserid() {
		return userid;
	}
	public void setUserid(Long userid) {
		this.userid = userid;
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
	    this._writeData(list);
		return null;
	}
	private void _writeData(Object obj){
		StringBuffer resultReponse = new StringBuffer(callback+"({\"articles\":");
        try {
        	resultReponse.append(JSONUtil.serialize(obj));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		resultReponse.append("});");
		this._writeData(resultReponse.toString());
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
	
	public String androidLogin(){
		AppUser user = appUserService.login(username, password);
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null){
			map.put("username",user.getUserName());
			map.put("userid", user.getUserId());
			map.put("email", user.getEmail());
			map.put("phone", user.getPhone());
			map.put("grade", user.getGrade().getGradeCode());
			map.put("state", 1);//1 成功 0 失败
		}else{
			AppUser user2 = appUserService.findAppUserByUserName(username);
			if(user2 != null){
				map.put("username",username);
			}else{
				map.put("username","");
			}
			map.put("userid", "");
			map.put("state", 0);//1 成功 0 失败
		}
		this._writeData(map);
		return null;
	}
	/**
	 * 重置时验证原密码
	 * @return
	 */
	public String androidAjaxLogin(){
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		AppUser user = appUserService.login(userid, password);
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null){
			map.put("state", 1);//1 成功 0 失败
		}else{
			map.put("state", 0);//1 成功 0 失败
		}
		AjaxResponseUtil.returnData(request, response, "", map);
		return null;
	}
	public String androidRegist(){
		AppUser user = new AppUser();
		user.setUserName(username);
		user.setIsValid("1");
		user.setPassWord(password);
		user.setPhone(phone);
		user.setRegistTime(new Date());
		user.setRole("ROLE_USER");
		user.setEmail(email);
		user.setGrade(gradeService.get(1L));//默认等级为1
		appUserService.save(user);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username",user.getUserName());
		map.put("userid", user.getUserId());
		map.put("grade", user.getGrade().getGradeCode());
		map.put("email", user.getEmail());
		map.put("phone", user.getPhone());
		map.put("state", 1);//1 成功 0 失败
		this._writeData(map);
		return null;
	}
	public String androidReset(){
		AppUser user = appUserService.get(userid);
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null && !"".equals(user)){
			user.setPassWord(password);
			appUserService.update(user);
			map.put("state", 1);//1 成功 0 失败
		}else{
			map.put("state", 0);//1 成功 0 失败
		}
		this._writeData(map);
		return null;
	}
	public String getLatestVersion(){
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		Version versionLast = versionService.getLatestVersion(clientType);
		Map<String, Object> map = new HashMap<String, Object>();
		if(versionLast != null && versionLast.getVersion() > version){
			map.put("url",versionLast.getUrl());
			map.put("version", versionLast.getVersion());
			map.put("name", versionLast.getName());
			map.put("content", versionLast.getContent());
			map.put("upgradeType", versionLast.getUpgradeType());
		}
		AjaxResponseUtil.returnData(request, response, "", map);
		return null;
	}
}
