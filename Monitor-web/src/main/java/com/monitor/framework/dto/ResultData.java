package com.monitor.framework.dto;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ResultData<T> implements Serializable {

	private boolean isSuccessful;
	
	private int code;
	
	private T serializableData;
	
	private String messageEnum;
	
	private String message;

	public ResultData() {
		
	}
	

	public boolean isSuccessful() {
		return isSuccessful;
	}

	public void setSuccessful(boolean isSuccessful) {
		this.isSuccessful = isSuccessful;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public void setSerializableData(T serializableData) {
		this.serializableData = serializableData;
	}

	public String getMessageEnum() {
		return messageEnum;
	}

	public void setMessageEnum(String messageEnum) {
		this.messageEnum = messageEnum;
	}

	public T getSerializableData() {
		return serializableData;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
