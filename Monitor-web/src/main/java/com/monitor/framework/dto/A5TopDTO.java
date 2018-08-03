package com.monitor.framework.dto;

import java.io.Serializable;

public class A5TopDTO implements Serializable{
	
	private static final long serialVersionUID = -7355550398560128789L;

	private Integer no;
	
	private String name;
	
	private Integer count;

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
}
