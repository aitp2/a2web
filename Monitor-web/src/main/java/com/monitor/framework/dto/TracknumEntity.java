package com.monitor.framework.dto;

import java.io.Serializable;

public class TracknumEntity implements Serializable{
	
	private String logsource;
	
	private String logtime;
	
	private String orderCode;
	
	private String message;
	
	private String error;

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

}
