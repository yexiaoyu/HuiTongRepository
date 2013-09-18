package cn.com.huitong.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 权限控制
 * @author Administrator
 *
 */
@Entity
@Table(name="Grade")
public class Grade implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gradeId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long gradeId;
	@Column(name="gradeCode")
	private String gradeCode;
	@Column(name="gradeName")
	private String gradeName;
	public Long getGradeId() {
		return gradeId;
	}
	public void setGradeId(Long gradeId) {
		this.gradeId = gradeId;
	}
	public String getGradeCode() {
		return gradeCode;
	}
	public void setGradeCode(String gradeCode) {
		this.gradeCode = gradeCode;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	@Override
	public String toString() {
		return gradeCode;
	}

}