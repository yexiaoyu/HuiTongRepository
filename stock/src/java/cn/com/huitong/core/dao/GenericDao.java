package cn.com.huitong.core.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import cn.com.huitong.core.common.PagingBean;

public interface GenericDao<T extends Serializable, PK extends Serializable> {
	public abstract Session getSession();
	
	public abstract T get(PK paramPK);
	
	public abstract List<T> getAll(Class<T> clazz);

	public abstract boolean exists(PK paramPK);

	public abstract void save(T paramObject);

	public abstract void update(T paramT);

	public abstract void deleteByPK(PK paramPK);

	public abstract void delete(Object paramObject);
	
	public abstract List<T> findByHQL(String hql);
	
	public abstract List<T> findByHQL(String hql,Map<String, Object> map);
	
	public abstract Object findBySQL(String sql);
	
	public abstract Object findBySQL(String sql,Map<String,Object> map);
	//分页查询
	public abstract List<T> findByHqlAndPage(String hql, Map<String, Object> map, PagingBean pb);

	// public abstract List<T> find(QueryRule paramQueryRule);

	// public abstract Page find(QueryRule paramQueryRule, int paramInt1, int
	// paramInt2);

	//public abstract T findUnique(Map<String, Object> paramMap);

	// public abstract T findUnique(QueryRule paramQueryRule);
}
