package com.monitor.framework.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.monitor.framework.annotation.Header;

@Entity
@Table(name = "tbl_system_flow")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "fieldHandler" })
public class SystemFlow  extends BaseEntity{

	private static final long serialVersionUID = 4626877710479184517L;

	@Header(name = "track类型")
    @Column(name = "tracknumtype")
	private String tracknumtype;
	
	@Header(name = "节点序号")
    @Column(name = "nodeno")
	private String nodeno;
	
	@Header(name = "节点名称")
    @Column(name = "name")
	private String name;
	
	@Header(name = "正常匹配规则")
    @Column(name = "nomarl_pattern")
	private String nomarl_pattern;
	
	@Header(name = "异常匹配规则")
    @Column(name = "exception_pattern")
	private String exception_pattern;

	public String getTracknumtype() {
		return tracknumtype;
	}

	public void setTracknumtype(String tracknumtype) {
		this.tracknumtype = tracknumtype;
	}

	public String getNodeno() {
		return nodeno;
	}

	public void setNodeno(String nodeno) {
		this.nodeno = nodeno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNomarl_pattern() {
		return nomarl_pattern;
	}

	public void setNomarl_pattern(String nomarl_pattern) {
		this.nomarl_pattern = nomarl_pattern;
	}

	public String getException_pattern() {
		return exception_pattern;
	}

	public void setException_pattern(String exception_pattern) {
		this.exception_pattern = exception_pattern;
	}
}
