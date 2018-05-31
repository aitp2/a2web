package com.monitor.framework.base.service;

import java.util.List;

import com.monitor.framework.base.entity.AlertRule;

public interface AlertRuleService extends BaseService{

	public List<AlertRule> getAllEnableAlertRules();
}
