package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.EconomicCalenda;

public interface EconomicService extends GenericDao<EconomicCalenda, Long>{

	List<EconomicCalenda> findAllEconomicValid(EconomicCalenda economic,PagingBean pb);

}
