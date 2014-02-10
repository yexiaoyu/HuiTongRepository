package cn.com.huitong.model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="News")
public class News implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String type;
	private String typeName;
	private String content;
	private String shortContent;
	private String title;
	private Date modifyTime;
	private String isValid;
	private String remark;

	public static final Map<String, String> newsTypeMap = new HashMap<String, String>();
	static{
		newsTypeMap.put("89", "市场热点");
		newsTypeMap.put("90", "概念热点");
		newsTypeMap.put("91", "公司资讯");
		newsTypeMap.put("92", "全球资讯");
		newsTypeMap.put("93", "股市直播");
		newsTypeMap.put("94", "涨停板掘金");
		newsTypeMap.put("82", "最新要闻");
		newsTypeMap.put("83", "概念要闻");
		newsTypeMap.put("84", "财经日历");
		newsTypeMap.put("86", "最新资讯");
		newsTypeMap.put("87", "普通资讯");
		newsTypeMap.put("88", "VIP资讯");
	}
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@Column(name="type")
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(name="shortContent")
	public String getShortContent() {
		return shortContent;
	}
	public void setShortContent(String shortContent) {
		this.shortContent = shortContent;
	}
	@Column(name="title")
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Column(name="modifyTime")
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	@Column(name="isValid")
	public String getIsValid() {
		return isValid;
	}
	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}
	@Column(name="remark")
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Column(name="typeName")
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
}
