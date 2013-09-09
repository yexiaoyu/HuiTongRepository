package cn.com.huitong.core.servlet;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.gimpy.BlockGimpyRenderer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.ChineseTextProducer;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;
import nl.captcha.text.renderer.WordRenderer;

public class SimpleCaptchaServlet extends HttpServlet {
	private static final String PARAM_HEIGHT = "height";
	private static final String PARAM_WIDTH = "width";
	private static final String PAEAM_NOISE = "noise";
	private static final String PAEAM_BORDER = "border";
	private static final String PAEAM_TEXT = "text";
	protected int _width = 200;
	protected int _height = 50;
	protected boolean _noise = false;
	protected boolean _border = false;
	protected String _text = null;

	public void init() throws ServletException {
		if (getInitParameter("height") != null) {
			this._height = Integer.valueOf(getInitParameter("height"))
					.intValue();
		}

		if (getInitParameter("width") != null) {
			this._width = Integer.valueOf(getInitParameter("width")).intValue();
		}

		if (getInitParameter("noise") != null) {
			this._noise = Boolean.valueOf(getInitParameter("noise"))
					.booleanValue();
		}

		if (getInitParameter("border") != null) {
			this._border = Boolean.valueOf(getInitParameter("border"))
					.booleanValue();
		}

		if (getInitParameter("text") != null)
			this._text = String.valueOf(getInitParameter("text"));
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Captcha.Builder builder = new Captcha.Builder(this._width, this._height);

		if (this._border) {
			builder.addBorder();
		}

		if (this._noise) {
			builder.addNoise();
		}

		List fontList = new ArrayList();

		fontList.add(new Font("Courier", 1, 45));
		DefaultWordRenderer dwr = new DefaultWordRenderer(Color.black, fontList);

		WordRenderer wr = dwr;

		if (this._text == null) {
			builder.addText();
		} else {
			String[] ts = this._text.split(",");
			for (int i = 0; i < ts.length; i++) {
				String[] ts1 = ts[i].split(":");
				if ("chinese".equals(ts1[0])) {
					builder.addText(new ChineseTextProducer(Integer
							.parseInt(ts1[1])), wr);
				} else if ("number".equals(ts1[0])) {
					char[] numberChar = { '2', '3', '4', '5', '6', '7', '8' };
					builder.addText(new DefaultTextProducer(Integer
							.parseInt(ts1[1]), numberChar), wr);
				} else if ("word".equals(ts1[0])) {
					char[] numberChar = { 'a', 'b', 'c', 'd', 'e', 'f', 'g',
							'h', 'k', 'm', 'n', 'p', 'r', 'w', 'x', 'y' };
					builder.addText(new DefaultTextProducer(Integer
							.parseInt(ts1[1]), numberChar), wr);
				} else {
					builder.addText(new DefaultTextProducer(Integer
							.parseInt(ts1[1])), wr);
				}

			}

		}

		GradiatedBackgroundProducer gbp = new GradiatedBackgroundProducer();
		gbp.setFromColor(new Color(255, 235, 205));

		builder.addBackground(gbp);

		builder.gimp(new BlockGimpyRenderer(1));

		Captcha captcha = builder.build();
		System.out.println("验证码为："+captcha.getAnswer());
		CaptchaServletUtil.writeImage(resp, captcha.getImage());
		req.getSession().setAttribute("simpleCaptcha", captcha);
	}
}
