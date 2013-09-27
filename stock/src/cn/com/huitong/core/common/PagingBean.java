package cn.com.huitong.core.common;
/*
 *  广州粤能信息技术有限公司 OA办公管理系统   -- http://www.yuenengit.com
 *  Copyright (C) 2008-2009 GuangZhou YueNeng Information Technology Co.,LTD
*/

/**
 * 分页类
 */
public class PagingBean{
	
	public static final String PAGING_BEAN="_paging_bean";
	
	/**
	 * 后台每页显示条目
	 */
	public static Integer DEFAULT_PAGE_SIZE=25;
	/**
	 * 前台每页显示条目
	 */
	public static Integer DEFAULT_PAGE_SIZE_CLIENT=15;
	
	/**
	 * 最多显示页码数
	 */
	public static final int SHOW_PAGES=6;
	
	/**
	 * 每页开始的索引号
	 */
	public Integer start;
	//页码大小
	private Integer pageSize;

	//总记录数
	private Integer totalItems;
	
	private Integer pageCount = 0;//总页数
	
	public PagingBean(int start,int limit){
		this.pageSize=limit;
		this.start=start;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalItems() {
		return totalItems;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public void setTotalItems(Integer totalItems) {
		this.totalItems = totalItems;
	}

	public void setTotalItems(int totalItems) {
		this.totalItems = totalItems;		
				
	}
	
	public int getFirstResult(){
		return start;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}

}
