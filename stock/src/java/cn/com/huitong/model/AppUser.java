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
 * 用户
 * @author Administrator
 *
 */
@Entity
@Table(name="appuser")
public class AppUser implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="userid")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	/**ID*/
	private Long userId;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gradeId", nullable = false)
	/**用户等级*/
	private Grade grade;
	@Column(name="userName")
	/**用户名称*/
	private String userName;
	@Column(name="passWord")
	/**用户密码*/
	private String passWord;
	@Column(name="realName")
	/**用户真实姓名*/
	private String realName;
	@Column(name="email")
	/**用户电子邮箱*/
	private String email;
	@Column(name="phone")
	/**用户手机或电话*/
	private String phone;
	@Temporal(TemporalType.DATE)
	@Column(name="registTime")
	/**用户注册时间*/
	private Date registTime;
	@Column(name="photo")
	/**用户头像URL*/
	private String photo;
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getRegistTime() {
		return registTime;
	}
	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}