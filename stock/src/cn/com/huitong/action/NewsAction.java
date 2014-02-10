package cn.com.huitong.action;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import nl.captcha.Captcha;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.common.Struts2Action;
import cn.com.huitong.model.News;
import cn.com.huitong.service.NewsService;
import cn.com.huitong.util.BeanUtil;

@SuppressWarnings("serial")
public class NewsAction extends Struts2Action{
	private String nodeName;
	private String checkCode;
	private News news;
	private Long id;
	private List<News> newsList;
	@Resource
	private NewsService newsService;
	
	private Map<String, String> typeMap = News.newsTypeMap;
	
	/**
	 * 后台访问入口
	 * @return
	 */
	public String operateNews(){
		String result = SUCCESS;
		if(nodeName != null && !"".equals(nodeName)){
			logger.debug("nodeName==" + nodeName);
			result = nodeName;
			if(nodeName.equals("add")){
				this._addNews();
			}else if(nodeName.equals("query") || nodeName.equals("queryEntry") 
					|| nodeName.equals("economicPage") || nodeName.equals("economicNewsPage")){
				this._queryNews();
			}else if(nodeName.equals("delete")){
				this._deleteNews();
			}else if(nodeName.equals("updateEntry")){
				this._updateNewsEntry();
			}else if(nodeName.equals("update")){
				this._updateNews();
			}else if(nodeName.equals("detail")){
				this._detailNews();
			}
		}
		//gradeList = gradeService.findGradeAll();
//		PagingBean pb = this.getInitPagingBean();
//		stockList = stockService.findAllStockValid(pb);
		return result;
	}
	private void _detailNews() {
		logger.debug("_detailNewsId--------" + id);
		news = newsService.get(id);
	}
	private void _addNews() {
		logger.debug("_addStock----");
		// 取得验证码
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(news != null && !"".equals(news)){
				news.setModifyTime(new Date());
				if(news.getContent() != null && !"".equals(news.getContent())){
					if(news.getContent().length()>20){
						news.setShortContent(news.getContent().substring(0,20));
					}else{
						news.setShortContent(news.getContent());
					}
				}
				news.setTypeName(typeMap.get(news.getType()));
				newsService.save(news);
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryNews();
	}
	private void _updateNews() {
		logger.debug("_updateNews--------");
		Captcha captcha = (Captcha) getSession().getAttribute(Captcha.NAME);
		if (captcha != null && captcha.isCorrect(checkCode)) {
			if(news != null && !"".equals(news)){
				News oldNews = newsService.get(news.getId());
				news.setModifyTime(new Date());
				news.setTypeName(typeMap.get(news.getType()));
				if(news.getContent() != null && !"".equals(news.getContent())){
					if(news.getContent().length()>20){
						news.setShortContent(news.getContent().substring(0,20));
					}else{
						news.setShortContent(news.getContent());
					}
				}
				try {
					BeanUtil.copyNotNullProperties(oldNews, news);
					newsService.save(oldNews);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}else{
			logger.debug("验证码不正确！");
		}
		this._queryNews();
	}
	private void _updateNewsEntry() {
		logger.debug("_updateNewsEntry--------" + id);
		news = newsService.get(id);
	}
	private void _deleteNews() {
		logger.debug("_deleteNews--------");
		if(id != null && !"".equals(id)){
			newsService.deleteByPK(id);
		}
		this._queryNews();
	}
	private void _queryNews() {
		logger.debug("_queryNews--------");
		PagingBean pb = this.getInitPagingBean();
		newsList = newsService.findNewsList(news,pb);
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public News getNews() {
		return news;
	}
	public void setNews(News news) {
		this.news = news;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public List<News> getNewsList() {
		return newsList;
	}
	public void setNewsList(List<News> newsList) {
		this.newsList = newsList;
	}
	public Map<String, String> getTypeMap() {
		return typeMap;
	}
	public void setTypeMap(Map<String, String> typeMap) {
		this.typeMap = typeMap;
	}
	
}
