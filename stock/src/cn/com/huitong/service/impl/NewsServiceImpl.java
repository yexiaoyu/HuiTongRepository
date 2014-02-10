package cn.com.huitong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.impl.GenericDaoImpl;
import cn.com.huitong.model.News;
import cn.com.huitong.service.NewsService;

public class NewsServiceImpl extends GenericDaoImpl<News, Long> implements NewsService{

	@Override
	public List<News> findNewsList(News news, PagingBean pb) {
		StringBuffer hql = new StringBuffer("FROM News s WHERE isValid = 1 ");
		Map<String, Object> param = new HashMap<String, Object>();
		if(news != null && !"".equals(news)){
			if(news.getType() != null && !"".equals(news.getType())){
				hql.append(" AND s.type=:type ");
				param.put("type",news.getType());
			}
		}
		hql.append("ORDER BY s.id DESC");
		log.debug("SQL====" + hql);
		return this.findByHqlAndPage(hql.toString(),param,pb);
	}
}
