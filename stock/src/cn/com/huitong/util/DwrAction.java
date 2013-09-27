package cn.com.huitong.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;
import cn.com.huitong.core.common.Struts2Action;

import com.google.gson.Gson;

public class DwrAction extends Struts2Action {
	private String checkCode;

	public String checkCodeValid() {
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		HttpServletResponse response = this.getResponse();
		try {
			PrintWriter pw = response.getWriter();
			Map<String, Integer> map = new HashMap<String, Integer>();
			// 验证码验证
			if (captcha != null && !captcha.isCorrect(checkCode)) {
				map.put("pass", 0);
			} else {
				map.put("pass", 1);
			}
			Gson gson = new Gson();
			String str = gson.toJson(map);
			pw.write(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
}
