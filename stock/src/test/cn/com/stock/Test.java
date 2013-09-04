package cn.com.stock;

import java.util.List;

import javax.annotation.Resource;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.service.AppUserService;
import cn.com.stock.core.BaseTestCase;

public class Test extends BaseTestCase {
	@Resource
	private AppUserService appUserService;
	
	@org.junit.Test
	public void test(){
		System.out.println("lll");
		PagingBean pagingBean = new PagingBean(1,15);
		List<AppUser> userList = appUserService.findAllValidUser(pagingBean);
		System.out.println(userList);
	}
}
