package cn.com.huitong.action;

import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;

import com.google.gson.Gson;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Grade;
import cn.com.huitong.service.AppUserService;
import cn.com.huitong.service.GradeService;
import cn.com.huitong.util.BeanUtil;

@SuppressWarnings("serial")
public class AppUserAction extends Struts2Action{
	
	//foreground  start
	private AppUser user;
	private Long userId;
	private String userName;
	@Resource(name="appUserService")
	private AppUserService appUserService;
	private String passWord2;
	@Resource(name="gradeService")
	private GradeService gradeService;
	private List<Grade> gradeList;
	private List<AppUser> userList;
	
	private String nodeName;
	private String checkCode;
	//foreground  end
	
	//前台注册
	@SuppressWarnings("unchecked")
	public String register(){
		// 取得验证码
		logger.debug("appuserAction.login........");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(user != null && !"".equals(user)){
				user.setRegistTime(new Date());
				user.setGrade(gradeService.get(user.getGrade().getGradeId()));
				user.setRole("ROLE_USER");
				appUserService.save(user);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		return SUCCESS;
	}

	public String loginIndex(){
		return SUCCESS;
	}
	//background  start
	/***
	 * 后台对用户操作的统一入口
	 */
	public String operateUser(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("add")){
				this.addUser();
			}else if(nodeName.equals("updateEntry")){
				this.updateUserEntry();
			}else if(nodeName.equals("update")){
				this.updateUser();
			}else if(nodeName.equals("query") || nodeName.equals("queryEntry")){
				this.queryUser();
			}else if(nodeName.equals("delete")){
				this.deleteUser();
			}else{
			}
		}
		gradeList = gradeService.findGradeAll();
		return result;
	}
	public String checkUserNameValid(){
		if(userName != null && !"".equals(userName)){
			List<String> userNames = appUserService.findAllUserName();
			HttpServletResponse response = this.getResponse();
			try {
				PrintWriter pw = response.getWriter();
				Map<String,Integer> map = new HashMap<String,Integer>();
				if(userNames != null && !"".equals(userNames) && userNames.size()>0){
					if(userNames.contains(userName)){
						map.put("pass", 0);
					}else{
						map.put("pass", 1);
					}
				}
				Gson gson = new Gson();
				String str = gson.toJson(map);
				pw.write(str);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}
	
//	public String addUserEntry(){
//		logger.debug("addUserEntry.........");
//		gradeList = gradeService.findGradeAll();
//		return SUCCESS;
//	}
	public String addUser(){
		logger.debug("addUser.........");
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(user != null && !"".equals(user)){
				user.setRegistTime(new Date());
				user.setGrade(gradeService.get(user.getGrade().getGradeId()));
				user.setRole("ROLE_USER");
				appUserService.save(user);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		//-------------------------
		//gradeList = gradeService.findGradeAll();
		this.queryUser();
		return SUCCESS;
	}
	public String updateUserEntry(){
		logger.debug("updateUserEntry........." + userId);
		user = appUserService.get(userId);
		gradeList = gradeService.findGradeAll();
		return SUCCESS;
	}
	public String updateUser(){
		logger.debug("updateUser.........");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(user != null && !"".equals(user)){
				AppUser oldUser = appUserService.get(user.getUserId());
				try {
					BeanUtil.copyNotNullProperties(oldUser, user);
					oldUser.setGrade(gradeService.get(oldUser.getGrade().getGradeId()));
					appUserService.save(oldUser);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}else{
			logger.debug("验证码不正确！");
		}
		//user = new AppUser();
		this.queryUser();
		return SUCCESS;
	}
//	public String queryUserEntry(){
//		//user = appUserService.get(8L);
//		logger.debug("queryUserEntry----");
//		//gradeList = gradeService.findGradeAll();
//		PagingBean pb = this.getInitPagingBean();
//		userList = appUserService.findAllValidUser(pb);
//		return SUCCESS;
//	}
	public String queryUser(){
		logger.debug("queryUser----");
		PagingBean pb = this.getInitPagingBean();
		userList = appUserService.findAllValidUser(user,pb);
		return SUCCESS;
	}  
	public String deleteUser(){
		logger.debug("deleteUser----" + userId);
		appUserService.deleteByPK(userId);
		this.queryUser();
//		PagingBean pb = this.getInitPagingBean();
//		userList = appUserService.findAllValidUser(user,pb);
		return SUCCESS;
	}
	
	
	//background  end
	
	public AppUser getUser() {
		return user;
	}

	public void setUser(AppUser user) {
		this.user = user;
	}

	public String getPassWord2() {
		return passWord2;
	}

	public void setPassWord2(String passWord2) {
		this.passWord2 = passWord2;
	}
	
	
	public String index(){
		return SUCCESS;
	}

	public List<Grade> getGradeList() {
		return gradeList;
	}

	public void setGradeList(List<Grade> gradeList) {
		this.gradeList = gradeList;
	}

	public List<AppUser> getUserList() {
		return userList;
	}

	public void setUserList(List<AppUser> userList) {
		this.userList = userList;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	
}
