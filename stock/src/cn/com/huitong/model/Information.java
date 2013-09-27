package cn.com.huitong.model;

import java.io.Serializable;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 内参资讯
 * @author Administrator
 *
 */
@Entity
@Table(name="Information")
public class Information implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="informId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long informId;
	@ManyToOne(fetch = FetchType.EAGER,targetEntity=Grade.class)
	@JoinColumn(name = "gradeId", nullable = false)
	/**用户等级**/
	private Grade grade;
	@ManyToOne(fetch = FetchType.EAGER, targetEntity=Stock.class)
	@JoinColumn(name = "stockId", nullable = false)
	/**股票**/
	private Stock stock;
	@Column(name="title")
	/**主题**/
	private String title;
	@Column(name="content")
	/**内容**/
	private String content;
	@Column(name="inputTime")
	/**录入时间**/
	private Date inputTime;
	@Column(name="isValid")
	/**是否有效*/
	private String isValid;
	public Long getInformId() {
		return informId;
	}
	public void setInformId(Long informId) {
		this.informId = informId;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public Stock getStock() {
		return stock;
	}
	public void setStock(Stock stock) {
		this.stock = stock;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getInputTime() {
		return inputTime;
	}
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}
	public String getIsValid() {
		return isValid;
	}
	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

}