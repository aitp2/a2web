package com.monitor.framework.dto;

import java.io.Serializable;

public class OrderStatusEntity implements Serializable{
	
	private String status;
	
	private String num;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	

}
