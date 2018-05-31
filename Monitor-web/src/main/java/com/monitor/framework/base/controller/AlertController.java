package com.monitor.framework.base.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.monitor.framework.annotation.RefreshCSRFToken;
import com.monitor.framework.annotation.VerifyCSRFToken;
import com.monitor.framework.base.entity.AlertRule;
import com.monitor.framework.base.pojo.Result;
import com.monitor.framework.base.service.AlertHistoryService;
import com.monitor.framework.base.service.AlertRuleService;
import com.monitor.framework.util.HttpClientUtil;
import com.monitor.framework.utils.PropertiesUtil;
import com.monitor.framework.utils.StrUtil;

@Controller
@RequestMapping(value = "/alert")
public class AlertController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(AlertController.class);

	@Resource
	private AlertRuleService alertRuleService;
	
	@Resource
	private AlertHistoryService alertHistoryService;

	/**
	 * 告警规则列表
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/alertRuleList")
	private String list() {

		return "base/alert/alertRule_list";
	}

	/**
	 * 告警规则编辑
	 *
	 * @return
	 */
	@RefreshCSRFToken
	@RequestMapping(method = RequestMethod.GET, value = "/editAlertRule")
	private String edit(String id, HttpServletRequest request) {

		request.setAttribute("id", id);
		return "base/alert/alertRule_edit";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/getAlertRule")
	@ResponseBody
	private AlertRule getAlertRule(String id) {

		return alertRuleService.get(AlertRule.class, id);
	}

	@VerifyCSRFToken
	@RequestMapping(method = RequestMethod.POST, value = "/saveAlertRule")
	@ResponseBody
	private Result saveAlertRule(AlertRule alertRule, HttpServletRequest request) {
		String id = "";
		if (StrUtil.isEmpty(alertRule.getId())) {
			id = alertRuleService.save(alertRule).toString();
		} else {
			alertRule.setUpdateDateTime(new Date());
			alertRuleService.update(alertRule);
			id = alertRule.getId();
		}
		// 同步更新AlertRuleCronjob
		Map<String, String> para = new HashMap<String, String>();
		para.put("id", id);
		para.put("name", alertRule.getName());
		para.put("status", alertRule.getStatus());
		try {
			String result = HttpClientUtil.httpGet(PropertiesUtil.getValue("microservice.url")
					+ "/updateAlertRuleCronjob", para);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Result(true);
	}
}
