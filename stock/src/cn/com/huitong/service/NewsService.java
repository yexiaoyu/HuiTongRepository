package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.News;

public interface NewsService extends GenericDao<News, Long>{

	public List<News> findNewsList(News news, PagingBean pb);
	
}
