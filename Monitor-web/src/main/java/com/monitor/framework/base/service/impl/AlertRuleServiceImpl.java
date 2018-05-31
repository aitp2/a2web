package com.monitor.framework.base.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.monitor.framework.base.dao.BaseDao;
import com.monitor.framework.base.entity.AlertRule;
import com.monitor.framework.base.service.AlertRuleService;

@Service("alertRuleService")
public class AlertRuleServiceImpl extends BaseServiceImpl implements AlertRuleService{
	
	@Resource
    private BaseDao baseDao;
	
	public List<AlertRule> getAllEnableAlertRules(){
		
		return baseDao.findBySql("select * from tbl_alert_rule where status='0'", AlertRule.class);
	}

}
