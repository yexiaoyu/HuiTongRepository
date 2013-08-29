package cn.com.huitong.core.common;

import com.opensymphony.xwork2.ActionSupport;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

public class Struts2Action extends ActionSupport
{
  private static final long serialVersionUID = 1L;
  protected static final Log logger = LogFactory.getLog(Struts2Action.class);
  protected int pageNo;
  protected int pageSize;

  public void setPageNo(int pageNo)
  {
    this.pageNo = pageNo;
  }

  public void setPageSize(int pageSize)
  {
    this.pageSize = pageSize;
  }

  public int getPageNo()
  {
    return this.pageNo;
  }

  public int getPageSize()
  {
    return this.pageSize;
  }

  protected void render(String text, String contentType)
  {
    try
    {
      HttpServletResponse response = getResponse();
      response.setContentType(contentType);
      response.getWriter().write(text);
    } catch (IOException e) {
      logger.error(e.getMessage(), e);
      throw new IllegalStateException(e);
    }
  }

  protected void renderText(String text)
  {
    render(text, "text/plain;charset=UTF-8");
  }

  protected void renderHtml(String text)
  {
    render(text, "text/html;charset=UTF-8");
  }

  protected void renderXML(String text)
  {
    render(text, "text/xml;charset=UTF-8");
  }

  protected void saveMessage(String msg)
  {
    List messages = (List)getRequest().getSession().getAttribute(
      "messages");
    if (messages == null) {
      messages = new ArrayList();
    }
    messages.add(msg);
    getSession().setAttribute("messages", messages);
  }

  protected HttpServletRequest getRequest()
  {
    return ServletActionContext.getRequest();
  }

  protected ServletContext getServletContext()
  {
    return ServletActionContext.getServletContext();
  }

  protected HttpServletResponse getResponse()
  {
    return ServletActionContext.getResponse();
  }

  protected HttpSession getSession()
  {
    return getRequest().getSession();
  }

  protected HttpSession getSession(boolean flag)
  {
    return getRequest().getSession(flag);
  }
}