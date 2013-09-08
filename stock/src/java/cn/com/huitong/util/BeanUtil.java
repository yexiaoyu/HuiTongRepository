package cn.com.huitong.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaProperty;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/** * 重写BeanUtils.copyProperties * */
public class BeanUtil extends BeanUtils {
	private static Log logger = LogFactory.getLog(BeanUtil.class);
	static {
		ConvertUtils.register(new DateConvert(), java.util.Date.class);
		ConvertUtils.register(new DateConvert(), java.sql.Date.class);
	}

	public static void copyNotNullProperties(Object dest, Object orig) throws IllegalAccessException, InvocationTargetException{
		 BeanUtilsBean beanUtils = BeanUtilsBean.getInstance();
	    if (dest == null) {
	      throw new IllegalArgumentException("No destination bean specified");
	    }
	    if (orig == null) {
	      throw new IllegalArgumentException("No origin bean specified");
	    }
	    if (logger.isDebugEnabled()) {
	      logger.debug("BeanUtils.copyProperties(" + dest + ", " + orig + ")");
	    }
	    if ((orig instanceof DynaBean)) {
	      DynaProperty[] origDescriptors = ((DynaBean)orig).getDynaClass()
	        .getDynaProperties();
	      for (int i = 0; i < origDescriptors.length; i++) {
	        String name = origDescriptors[i].getName();
	        if ((beanUtils.getPropertyUtils().isReadable(orig, name)) && 
	          (beanUtils.getPropertyUtils().isWriteable(dest, name))) {
	          Object value = ((DynaBean)orig).get(name);
	          beanUtils.copyProperty(dest, name, value);
	        }
	      }
	    } else if ((orig instanceof Map)) {
	      Iterator entries = ((Map)orig).entrySet().iterator();
	      while (entries.hasNext()) {
	        Map.Entry entry = (Map.Entry)entries.next();
	        String name = (String)entry.getKey();
	        if (beanUtils.getPropertyUtils().isWriteable(dest, name))
	          beanUtils.copyProperty(dest, name, entry.getValue());
	      }
	    }else {
	      PropertyDescriptor[] origDescriptors = beanUtils.getPropertyUtils().getPropertyDescriptors(orig);
	      for (int i = 0; i < origDescriptors.length; i++) {
	        String name = origDescriptors[i].getName();
	        if (!"class".equals(name)){
	          if ((beanUtils.getPropertyUtils().isReadable(orig, name))
	        		  && (beanUtils.getPropertyUtils().isWriteable(dest, name)))
	            try {
	              Object value = beanUtils.getPropertyUtils().getSimpleProperty(orig, name);
	              if (value != null)//就在这里加了一句
	                beanUtils.copyProperty(dest, name, value);
	            }
	            catch (NoSuchMethodException localNoSuchMethodException){
	            }
	        }
	      }
	    }
	}
}
