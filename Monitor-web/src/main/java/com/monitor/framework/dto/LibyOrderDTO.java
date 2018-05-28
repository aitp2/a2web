package com.monitor.framework.dto;

import java.util.ArrayList;
import java.util.List;



public class LibyOrderDTO  implements Comparable<LibyOrderDTO>{
	
	private String orderCode;//
	
	private String splittime;
	
	private String sendsaptime;
	
	private String sapreturntime;
	
	private String dealtime;
	
	private List list_splittime = new ArrayList<String>();
	
	private List list_sendsaptime= new ArrayList<String>();
	
	private List list_sapreturntime= new ArrayList<String>();
	
	private List list_dealtime= new ArrayList<String>();

	public String getSplittime() {
		return splittime;
	}

	public void setSplittime(String splittime) {
		this.splittime = splittime;
	}

	public String getSendsaptime() {
		return sendsaptime;
	}

	public void setSendsaptime(String sendsaptime) {
		this.sendsaptime = sendsaptime;
	}

	public String getSapreturntime() {
		return sapreturntime;
	}

	public void setSapreturntime(String sapreturntime) {
		this.sapreturntime = sapreturntime;
	}

	public String getDealtime() {
		return dealtime;
	}

	public void setDealtime(String dealtime) {
		this.dealtime = dealtime;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public List getList_splittime() {
		return list_splittime;
	}

	public void setList_splittime(List list_splittime) {
		this.list_splittime = list_splittime;
	}

	public List getList_sendsaptime() {
		return list_sendsaptime;
	}

	public void setList_sendsaptime(List list_sendsaptime) {
		this.list_sendsaptime = list_sendsaptime;
	}

	public List getList_sapreturntime() {
		return list_sapreturntime;
	}

	public void setList_sapreturntime(List list_sapreturntime) {
		this.list_sapreturntime = list_sapreturntime;
	}

	public List getList_dealtime() {
		return list_dealtime;
	}

	public void setList_dealtime(List list_dealtime) {
		this.list_dealtime = list_dealtime;
	}

	public int compareTo(LibyOrderDTO arg0) {
        return arg0.getOrderCode().compareTo(this.orderCode);
    }
}
