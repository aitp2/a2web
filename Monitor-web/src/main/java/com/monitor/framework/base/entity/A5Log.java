package com.monitor.framework.base.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.monitor.framework.annotation.Header;
import com.monitor.framework.dto.A5EventEntity;
import com.monitor.framework.util.HttpUtil;

@Entity
@Table(name = "tbl_a5_log")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "fieldHandler" })
public class A5Log extends BaseEntity{

	private static final long serialVersionUID = -6072821309392964140L;
	
	@Header(name = "模块")
    @Column(name = "module")
	private String module;
	
	@Header(name = "模块实体id")
    @Column(name = "moduleEntryId")
	private String moduleEntryId;
	
	@Header(name = "模块实体标题")
    @Column(name = "moduleEntryTitle")
	private String moduleEntryTitle;
	
	@Header(name = "操作")
    @Column(name = "operator")
	private String operator;
	
	@Header(name = "操作时间")
    @Column(name = "operatorTime")
	private String operatorTime;
	
	@Header(name = "昵称")
    @Column(name = "nickname")
	private String nickname;
	
	@Header(name = "性别")
    @Column(name = "sex")
	private String sex;

	
private String hour;
	
	private Long countVisit;
	
	private Long countUser;

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public Long getCountVisit() {
		return countVisit;
	}

	public void setCountVisit(Long countVisit) {
		this.countVisit = countVisit;
	}

	public Long getCountUser() {
		return countUser;
	}

	public void setCountUser(Long countUser) {
		this.countUser = countUser;
	}

	
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getModuleEntryId() {
		return moduleEntryId;
	}

	public void setModuleEntryId(String moduleEntryId) {
		this.moduleEntryId = moduleEntryId;
	}

	public String getModuleEntryTitle() {
		return HttpUtil.baseDecoder(moduleEntryTitle);
	}

	public void setModuleEntryTitle(String moduleEntryTitle) {
		this.moduleEntryTitle = moduleEntryTitle;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperatorTime() {
		return operatorTime;
	}

	public void setOperatorTime(String operatorTime) {
		this.operatorTime = operatorTime;
	}

	public String getNickname() {
		//base64 decode
		return HttpUtil.baseDecoder(nickname);
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public A5Log() {
		super();
	}
	
	public A5Log(A5EventEntity a5EventEntity) {
		super();
		this.module = a5EventEntity.getModule();
		this.moduleEntryId = a5EventEntity.getModuleEntryId();
		this.moduleEntryTitle = a5EventEntity.getModuleEntryTitle();
		this.nickname= a5EventEntity.getNickname();
		this.operator = a5EventEntity.getOperator();
		this.operatorTime = a5EventEntity.getOperatorTime();
		this.sex = a5EventEntity.getSex();
	}

	
}
