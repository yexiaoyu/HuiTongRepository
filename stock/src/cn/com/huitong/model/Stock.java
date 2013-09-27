package cn.com.huitong.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 股票
 * @author Administrator
 *
 */
@Entity
@Table(name="Stock")
public class Stock implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="stockId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	/**ID*/
	private Long stockId;
	@Column(name="stockCode")
	/**股票代码*/
	private String stockCode;
	@Column(name="stockName")
	/**股票名称*/
	private String stockName;
	@Column(name="isValid")
	/**是否有效*/
	private String isValid;
	public Long getStockId() {
		return stockId;
	}
	public void setStockId(Long stockId) {
		this.stockId = stockId;
	}
	public String getStockCode() {
		return stockCode;
	}
	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public String getIsValid() {
		return isValid;
	}
	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

}