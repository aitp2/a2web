package com.monitor.framework.base.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.monitor.framework.base.entity.AlertRule;
import com.monitor.framework.base.entity.SystemFlow;
import com.monitor.framework.base.service.AlertRuleService;
import com.monitor.framework.base.service.SystemFlowService;
import com.monitor.framework.dto.ResultData;

@RestController
@RequestMapping("/api")
public class RestfullController {

	@Resource
	public AlertRuleService alertRuleService;
	
	@Resource
	public SystemFlowService systemFlowService;
	
	@RequestMapping(value="/getAllAlertRules", method=RequestMethod.GET)
    public ResultData<List<AlertRule>> queryExceptionByAggs(){
		List<AlertRule> list  = alertRuleService.getAllEnableAlertRules();
		return new ResultData<List<AlertRule>>(true, "success", 20000, list);
	}
	
	@RequestMapping(value="/getAlertRule", method=RequestMethod.GET)
    public ResultData<AlertRule> getAlertRule(@RequestParam(value = "id", required = true) String id){
		return new ResultData<AlertRule>(true, "success", 20000, alertRuleService.get(AlertRule.class, id));
	}
	
	@RequestMapping(value="/getSystemFlow", method=RequestMethod.GET)
    public ResultData<List<SystemFlow>> getSystemFlow(@RequestParam(value = "tracknumtype", required = true) String tracknumtype){
		return new ResultData<List<SystemFlow>>(true, "success", 20000, systemFlowService.getSystemFlowsByTracktype(tracknumtype));
	}
	
}
