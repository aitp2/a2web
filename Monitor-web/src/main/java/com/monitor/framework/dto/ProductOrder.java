package com.monitor.framework.dto;

import java.math.BigDecimal;

public class ProductOrder  implements Comparable<ProductOrder>{
	
	private String name;
	
	private BigDecimal totalprice;
	
	private String percentage; 
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	public int compareTo(ProductOrder arg0) {
        return arg0.getTotalprice().compareTo(this.getTotalprice());
    }

}
