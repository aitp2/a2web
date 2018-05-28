package com.monitor.framework.dto;

import java.io.Serializable;
import java.util.List;

public class TracknumEntity implements Serializable{
	
	private String logsource;
	
	private String logtime;
	
	private String orderCode;
	
	private String productCode;
	
	private String message;
	
	private String error;
	
	private List<TracknumEntity> listTracknumEntity;//按时间聚合

	public String getLogsource() {
		return logsource;
	}

	public void setLogsource(String logsource) {
		this.logsource = logsource;
	}

	public String getLogtime() {
		return logtime;
	}

	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public List<TracknumEntity> getListTracknumEntity() {
		return listTracknumEntity;
	}

	public void setListTracknumEntity(List<TracknumEntity> listTracknumEntity) {
		this.listTracknumEntity = listTracknumEntity;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}


}
