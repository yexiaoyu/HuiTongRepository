package cn.com.huitong.service;

import java.util.List;

import cn.com.huitong.core.common.PagingBean;
import cn.com.huitong.core.dao.GenericDao;
import cn.com.huitong.model.Information;

public interface InformationService extends GenericDao<Information, Long> {

	public List<Information> findAllInformationValid(Information information, PagingBean pb);

}
