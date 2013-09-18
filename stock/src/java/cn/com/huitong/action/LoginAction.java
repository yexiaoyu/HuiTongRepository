package cn.com.huitong.action;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;

import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.AppUser;
import cn.com.huitong.service.AppUserService;

public class LoginAction  extends Struts2Action{
	private AppUser user;
	private String username;
	private String password;
	private String checkCode;// 验证码
	
	private String key = "RememberAppUser";
	
	@Resource(name="appUserService")
	private AppUserService appUserService;
	
	@Resource(name = "myAuthenticationManager")
	private AuthenticationManager authenticationManager = null;
	
	public String login(){
		user = appUserService.findAppUserByUserName(username);
		
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);
		SecurityContext securityContext = SecurityContextHolder.getContext();
		securityContext.setAuthentication(authenticationManager.authenticate(authRequest));
		SecurityContextHolder.setContext(securityContext);
		getSession().setAttribute("SPRING_SECURITY_LAST_USERNAME", username);
		String rememberMe = getRequest().getParameter("_spring_security_remember_me");

		if (rememberMe != null && rememberMe.equals("on")) {
			// 加入cookie
			long tokenValiditySeconds = 1209600; // 14 days
			long tokenExpiryTime = System.currentTimeMillis() + (tokenValiditySeconds * 1000);
			String signatureValue = DigestUtils.md5Hex(username + ":" + tokenExpiryTime + ":" + user.getPassword() + ":" + key);
			String tokenValue = username + ":" + tokenExpiryTime + ":" + signatureValue;
			String tokenValueBase64 = new String(Base64.encodeBase64(tokenValue.getBytes()));
			getResponse().addCookie(makeValidCookie(tokenExpiryTime, tokenValueBase64));
		}
		
		return SUCCESS;
	}
	// add Cookie
	protected Cookie makeValidCookie(long expiryTime, String tokenValueBase64) {
		HttpServletRequest request = getRequest();
		Cookie cookie = new Cookie(TokenBasedRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY, tokenValueBase64);
		cookie.setMaxAge(60 * 60 * 24 * 365 * 5); // 5 years
		cookie.setPath(org.springframework.util.StringUtils.hasLength(request.getContextPath()) ? request.getContextPath() : "/");
		return cookie;
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

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public AppUser getUser() {
		return user;
	}

	public void setUser(AppUser user) {
		this.user = user;
	}
	
	
}
