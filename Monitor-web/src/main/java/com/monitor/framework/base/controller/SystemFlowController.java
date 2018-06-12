package com.monitor.framework.base.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.monitor.framework.annotation.RefreshCSRFToken;
import com.monitor.framework.annotation.VerifyCSRFToken;
import com.monitor.framework.base.entity.AlertRule;
import com.monitor.framework.base.entity.SystemFlow;
import com.monitor.framework.base.pojo.Result;
import com.monitor.framework.base.service.SystemFlowService;
import com.monitor.framework.util.HttpClientUtil;
import com.monitor.framework.utils.PropertiesUtil;
import com.monitor.framework.utils.StrUtil;

@Controller
@RequestMapping(value = "/systemflow")
public class SystemFlowController {

	@Resource
	private SystemFlowService systemFlowService;
	
	/**
	 * 列表
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/list")
	private String list() {
		return "base/systemflow/list";
	}
	
	/**
	 * 编辑
	 *
	 * @return
	 */
	@RefreshCSRFToken
	@RequestMapping(method = RequestMethod.GET, value = "/edit")
	private String edit(String id, HttpServletRequest request) {
		request.setAttribute("id", id);
		return "base/systemflow/edit";
	}
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/get")
	@ResponseBody
	private SystemFlow get(String id) {
		return systemFlowService.get(SystemFlow.class, id);
	}
	
	@VerifyCSRFToken
	@RequestMapping(method = RequestMethod.POST, value = "/save")
	@ResponseBody
	private Result save(SystemFlow systemFlow, HttpServletRequest request) {
		String id = "";
		if (StrUtil.isEmpty(systemFlow.getId())) {
			id = systemFlowService.save(systemFlow).toString();
		} else {
			systemFlow.setUpdateDateTime(new Date());
			systemFlowService.update(systemFlow);
			id = systemFlow.getId();
		}
		return new Result(true);
	}
}
