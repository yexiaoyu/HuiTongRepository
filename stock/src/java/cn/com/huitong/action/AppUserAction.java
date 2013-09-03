package cn.com.huitong.action;

import java.util.List;

import javax.annotation.Resource;

import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.model.Grade;
import cn.com.huitong.service.AppUserService;
import cn.com.huitong.service.GradeService;

@SuppressWarnings("serial")
public class AppUserAction extends Struts2Action{
	
	//foreground  start
	private AppUser user;
	@Resource(name="appUserService")
	private AppUserService appUserService;
	private String passWord2;
	@Resource(name="gradeService")
	private GradeService gradeService;
	private List<Grade> gradeList;
	//foreground  end
	
	
	@SuppressWarnings("unchecked")
	public String login(){
//		System.out.println(user.getUserName() );
//		System.out.println(user.getPassWord() );
//		System.out.println("appUserService==="+appUserService);
//		List<AppUser> users = appUserService.getAll(AppUser.class);
//		AppUser user = appUserService.get(4L);
//		System.out.println("user4=" + user);
		
//		String hql = "FROM AppUser WHERE userId in :userId";
//		Map<String, Object> parm = new HashMap<String, Object>();
//		List<Long> ids = new ArrayList<Long>();
//		ids.add(1L);
//		ids.add(2L);
//		ids.add(3L);
//		parm.put("userId", ids);
//		List<AppUser> users = appUserService.findByHQL(hql,parm);
//		System.out.println("users"+users);
		
		/*String sql = "SELECT userid,username,password FROM AppUser WHERE userId>4";
		Object obj = appUserService.findBySQL(sql);
		//如果查询列有多条时，则应该是List<Object[]>
		//如果查询列只有一个时，则就是一个Object
		List<Object[]> objl = (List<Object[]>)obj;
		for(Object[] l : objl){			
			System.out.println("0="+l[0]);
			System.out.println("1="+l[1]);
			System.out.println("2="+l[2]);
		}
		System.out.println("users"+obj);*/
		
//		String sql = "SELECT userid,username,password FROM AppUser WHERE userId>:userId";
//		Map<String, Object> parm = new HashMap<String, Object>();
//		parm.put("userId", 4);
//		Object obj = appUserService.findBySQL(sql,parm);
//		//如果查询列有多条时，则应该是List<Object[]>
//		//如果查询列只有一个时，则就是一个Object
//		List<Object[]> objl = (List<Object[]>)obj;
//		for(Object[] l : objl){			
//			System.out.println("0="+l[0]);
//			System.out.println("1="+l[1]);
//			System.out.println("2="+l[2]);
//		}
//		System.out.println("users"+obj);
		
		System.out.println(user);
		appUserService.save(user);
//		appUserService.saveAppUser(user);
		return SUCCESS;
	}

	public String loginIndex(){
		return SUCCESS;
	}
	public String queryUser(){
		user = appUserService.get(8L);
		return SUCCESS;
	}
	//background  start
	public String addUserEntry(){
		logger.debug("addUserEntry.........");
		gradeList = gradeService.findGradeAll();
		return SUCCESS;
	}
	public String addUser(){
		logger.debug("addUser.........");
		if(passWord2 != null && passWord2.equals(user.getPassWord())){
			appUserService.save(user);
		}
		//-------------------------
		gradeList = gradeService.findGradeAll();
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
	
}
