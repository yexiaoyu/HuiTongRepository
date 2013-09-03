package cn.com.huitong.core.dao.impl;


import java.io.OutputStream;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Appender;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.core.util.GenericsUtils;

public class GenericDaoImpl<T extends Serializable, E extends Serializable>  implements GenericDao<T, E> {

	private Class<T> entityClass;
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	public Logger log;
	
	public GenericDaoImpl() {
		this.entityClass = GenericsUtils.getSuperClassGenricType(getClass());
		log = Logger.getLogger(this.entityClass);
		//log.setLevel(Level.DEBUG);
		//PropertyConfigurator.configure("/WEB-INF/classes/log4j.properties");
		//log.setLevel(Level.DEBUG);
		
//		Appender appender = new  ConsoleAppender();
//		log.addAppender(appender);
		//System.out.println("entityClass---"+this.entityClass);
	}

	public GenericDaoImpl(Class<T> entityClass) {
		super();
		this.entityClass = entityClass;
	}

	public void delete(Object paramObject) {
		getSession().delete(paramObject);
	}

	public boolean exists(E paramE) {
		return getSession().contains(get(paramE));
	}

//	public T findUnique(Map<String, Object> paramMap) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	public T get(E paramPK) {
		return (T)getSession().get(this.entityClass, paramPK);
	}

	public void save(Object paramObject) {
		getSession().save(paramObject);
	}

	public void update(T paramT) {
		getSession().update(paramT);
	}

	public void deleteByPK(E paramPK) {
		getSession().delete(get(paramPK));
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public List<T> getAll(Class<T> clazz) {
		//Criteria是做条件查询的
		return getSession().createCriteria(clazz).list();
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public List<T> findByHQL(String hql) {
		return getSession().createQuery(hql).list();
	}
	/**
	 * "FROM AppUser WHERE userId in :userId";
	 *  map.put("userId", ids);
	 */
	public List<T> findByHQL(String hql,Map<String, Object> map) {
		Query query = getSession().createQuery(hql);
		if(map != null && !"".equals(map) && !map.isEmpty()){
			Set<Map.Entry<String, Object>> entrySet = map.entrySet();
			for(Map.Entry<String, Object> entry : entrySet){
				Object obj = entry.getValue();
				if(obj instanceof Collection){
					query.setParameterList(entry.getKey(), (Collection)obj);
				}else{
					query.setParameter(entry.getKey(), obj);
				}
			}
		}
		return query.list();
	}
	
	/**String sql = "SELECT userid,username,password FROM AppUser WHERE userId>4";
		Object obj = appUserService.findBySQL(sql);
		//如果查询列有多条时，则应该是List<Object[]>
		//如果查询列只有一个时，则就是一个Object
		List<Object[]> objl = (List<Object[]>)obj;
		for(Object[] l : objl){			
			System.out.println("0="+l[0]);
			System.out.println("1="+l[1]);
			System.out.println("2="+l[2]);
	}*/
	public Object findBySQL(String sql) {
		return getSession().createSQLQuery(sql).list();
		//只有使用select * from 或select all column from 才能使用下面转化为实体
		//return getSession().createSQLQuery(sql).addEntity(this.entityClass).list();
	}
	public Object findBySQL(String sql,Map<String,Object> map){
		Query query = getSession().createSQLQuery(sql);
		if(map != null && !"".equals(map) && !map.isEmpty()){
			Set<Map.Entry<String, Object>> entrySet = map.entrySet();
			for(Map.Entry<String, Object> entry : entrySet){
				Object obj = entry.getValue();
				if(obj instanceof Collection){
					query.setParameterList(entry.getKey(), (Collection)obj);
				}else{
					query.setParameter(entry.getKey(), obj);
				}
			}
		}
		return query.list();
	}
	
	 public List<T> findByHqlAndPage(String hql, Map<String, Object> map, PagingBean pb){
		 Integer pageSize = pb.getPageSize();
		 int totalItems = getTotalItems(hql, map).intValue();
		 int pageCount = (totalItems + pageSize.intValue() - 1) / pageSize.intValue();
		 pb.setTotalItems(totalItems);
		 pb.setPageCount(pageCount);
		 int startrow = pageSize.intValue() * (pb.getFirstResult() - 1);
		 
		 Query query = getSession().createQuery(hql);
		 if(map != null && !"".equals(map) && !map.isEmpty()){
				Set<Map.Entry<String, Object>> entrySet = map.entrySet();
				for(Map.Entry<String, Object> entry : entrySet){
					Object obj = entry.getValue();
					if(obj instanceof Collection){
						query.setParameterList(entry.getKey(), (Collection)obj);
					}else{
						query.setParameter(entry.getKey(), obj);
					}
				}
		 }
		 query.setFirstResult(startrow).setMaxResults(pageSize);
		 return query.list();
	 }
	 public Long getTotalItems(String hql, Map<String, Object> map){
		 String sql = "SELECT COUNT(*) sum " + hql;
		 Object obj = this.findBySQL(sql, map);
		 List result = (List)obj;
		 log.debug("TotalItems=" +Long.valueOf(result.get(0).toString()));
		 return Long.valueOf(result.get(0).toString());
	}
}
