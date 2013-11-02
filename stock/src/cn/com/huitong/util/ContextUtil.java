package cn.com.huitong.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import cn.com.huitong.model.AppUser;

public class ContextUtil {
	protected static final Log logger = LogFactory.getLog(ContextUtil.class);
	public static AppUser getCurrentUser() {
		SecurityContext securityContext = SecurityContextHolder.getContext();
		if (securityContext != null) {
			Authentication auth = securityContext.getAuthentication();
			if (auth != null) {
				Object principal = auth.getPrincipal();
				if ((principal instanceof AppUser)){
					AppUser user = (AppUser) principal;
					logger.debug("登录用户："+user.getUserName());
					return user;
				}
			} else {
				logger.warn("WARN: securityContext cannot be lookuped using SecurityContextHolder.");
			}
		}
		return null;
	}
}
