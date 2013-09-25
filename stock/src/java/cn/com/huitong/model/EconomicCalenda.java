package cn.com.huitong.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="EconomicCalenda")
public class EconomicCalenda implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private Long economicID;
	/**
	 * 关联个股
	 */
	private Stock stock;
	/**
	 * 1. 财经会议, 2.财经事件
	 */
	private Short isEvent;
	/**
	 * 进行的日期
	 */
	private Date time;
	/**
	 * 相关主题
	 */
	private String topic;
	/**
	 * 相关内容
	 */
	private String content;
	/**
	 * 1. 国际,2. 国际
	 */
	private Short isInland;
	/**
	 * 1.经济会议，2.政治会议，3.其他会议
	 */
	private Short meetingType;
	/**
	 * 1.利空,2.利好,3.中性
	 */
	private Short impactType;
	/**
	 * 影响时限 1天，5天，10天等
	 */
	private String impactLimit;
	/**
	 * 备注
	 */
	private String remark;
	
	private Short isValid;
	@Id
	@Column(name="economicID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getEconomicID() {
		return economicID;
	}
	public void setEconomicID(Long economicID) {
		this.economicID = economicID;
	}
	@ManyToOne(fetch = FetchType.EAGER, targetEntity=Stock.class)
	@JoinColumn(name = "stockId", nullable = false)
	public Stock getStock() {
		return stock;
	}
	public void setStock(Stock stock) {
		this.stock = stock;
	}
	@Column(name="time")
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	@Column(name="topic")
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(name="impactLimit")
	public String getImpactLimit() {
		return impactLimit;
	}
	public void setImpactLimit(String impactLimit) {
		this.impactLimit = impactLimit;
	}
	@Column(name="remark")
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Column(name="isEvent")
	public Short getIsEvent() {
		return isEvent;
	}
	public void setIsEvent(Short isEvent) {
		this.isEvent = isEvent;
	}
	@Column(name="isInland")
	public Short getIsInland() {
		return isInland;
	}
	public void setIsInland(Short isInland) {
		this.isInland = isInland;
	}
	@Column(name="meetingType")
	public Short getMeetingType() {
		return meetingType;
	}
	public void setMeetingType(Short meetingType) {
		this.meetingType = meetingType;
	}
	@Column(name="impactType")
	public Short getImpactType() {
		return impactType;
	}
	public void setImpactType(Short impactType) {
		this.impactType = impactType;
	}
	@Column(name="isValid")
	public Short getIsValid() {
		return isValid;
	}
	public void setIsValid(Short isValid) {
		this.isValid = isValid;
	}
}