package com.monitor.framework.base.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.monitor.framework.annotation.Header;

@Entity
@Table(name = "tbl_alert_history")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "fieldHandler" })
public class AlertHistory extends BaseEntity{

	private static final long serialVersionUID = -2134395470856124364L;
	
	@Header(name = "告警规则id")
    @Column(name = "id_alert_rule")
	private String alertRule;
	
	@Header(name = "规则名称")
    @Column(name = "rule_name")
	private String ruleName;
	
	@Header(name = "发送邮箱")
    @Column(name = "email_to")
	private String emailTo;
	
	@Header(name = "邮件标题")
    @Column(name = "email_subject")
	private String emailSubject;
	
	@Header(name = "邮件信息")
    @Column(name = "email_body")
	private String emailBody;

	public String getAlertRule() {
		return alertRule;
	}

	public void setAlertRule(String alertRule) {
		this.alertRule = alertRule;
	}

	public String getRuleName() {
		return ruleName;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	public String getEmailTo() {
		return emailTo;
	}

	public void setEmailTo(String emailTo) {
		this.emailTo = emailTo;
	}

	public String getEmailSubject() {
		return emailSubject;
	}

	public void setEmailSubject(String emailSubject) {
		this.emailSubject = emailSubject;
	}

	public String getEmailBody() {
		return emailBody;
	}

	public void setEmailBody(String emailBody) {
		this.emailBody = emailBody;
	}

}
