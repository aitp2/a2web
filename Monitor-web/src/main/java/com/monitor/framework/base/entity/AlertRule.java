package com.monitor.framework.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.monitor.framework.annotation.Header;

@Entity
@Table(name = "tbl_alert_rule")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "fieldHandler" })
public class AlertRule extends BaseEntity{

	private static final long serialVersionUID = 441400757257337267L;
	
	//告警基础
	
	@Header(name = "名称")
    @Column(name = "name")
    private String name;
    
	@Header(name = "描述")
    @Column(name = "description")
    private String description;

	@Header(name = "状态")
    @Column(name = "status")
    private String status;

    //告警触发
	
	@Header(name = "定时调度")
    @Column(name = "cron")
    private String cron;
    
	@Header(name = "查询条件")
    @Column(name = "textCondition")
    private String textCondition;
    
	@Header(name = "时间范围")
    @Column(name = "timeRange")
    private String timeRange;
    
	@Header(name = "查询结果比较")
    @Column(name = "resultNumCompareFlag")
    private String resultNumCompareFlag;
    
	@Header(name = "查询结果比较值")
    @Column(name = "resultNumCompareNum")
    private String resultNumCompareNum;
    
    //告警通知 - 邮件
    
	@Header(name = "发送邮件地址")
    @Column(name = "email_to")
    private String email_to;
    
	@Header(name = "邮件标题")
    @Column(name = "email_subject")
    private String email_subject;
    
	@Header(name = "邮件内容")
    @Column(name = "email_body")
    private String email_body;
    
    //告警抑制  在2h内,告警超过1次后,5h内不再发送告警通知       2-h:1;5-h
	@Header(name = "告警抑制")
    @Column(name = "restrain")
    private String restrain;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCron() {
		return cron;
	}

	public void setCron(String cron) {
		this.cron = cron;
	}

	public String getTextCondition() {
		return textCondition;
	}

	public void setTextCondition(String textCondition) {
		this.textCondition = textCondition;
	}

	public String getResultNumCompareFlag() {
		return resultNumCompareFlag;
	}

	public void setResultNumCompareFlag(String resultNumCompareFlag) {
		this.resultNumCompareFlag = resultNumCompareFlag;
	}

	public String getResultNumCompareNum() {
		return resultNumCompareNum;
	}

	public void setResultNumCompareNum(String resultNumCompareNum) {
		this.resultNumCompareNum = resultNumCompareNum;
	}

	public String getEmail_to() {
		return email_to;
	}

	public void setEmail_to(String email_to) {
		this.email_to = email_to;
	}

	public String getEmail_subject() {
		return email_subject;
	}

	public void setEmail_subject(String email_subject) {
		this.email_subject = email_subject;
	}

	public String getEmail_body() {
		return email_body;
	}

	public void setEmail_body(String email_body) {
		this.email_body = email_body;
	}

	public String getRestrain() {
		return restrain;
	}

	public void setRestrain(String restrain) {
		this.restrain = restrain;
	}

	public String getTimeRange() {
		return timeRange;
	}

	public void setTimeRange(String timeRange) {
		this.timeRange = timeRange;
	}

}
