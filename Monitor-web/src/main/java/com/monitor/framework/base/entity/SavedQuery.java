package com.monitor.framework.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.monitor.framework.annotation.Header;

@Entity
@Table(name = "tbl_saved_query")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "fieldHandler" })
public class SavedQuery  extends BaseEntity{
	
	private static final long serialVersionUID = -8960862439869948792L;
	
	@Header(name = "名称")
    @Column(name = "name")
    private String name;
	
	@Header(name = "用户")
    @Column(name = "username")
    private String username;
	
	@Header(name = "url")
    @Column(name = "url")
    private String url;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
