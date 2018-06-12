package com.monitor.framework.base.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.monitor.framework.annotation.RefreshCSRFToken;
import com.monitor.framework.annotation.VerifyCSRFToken;
import com.monitor.framework.base.entity.SavedQuery;
import com.monitor.framework.base.pojo.Result;
import com.monitor.framework.base.service.SavedQueryService;
import com.monitor.framework.utils.StrUtil;

@Controller
@RequestMapping(value = "/savedQuery")
public class SavedQueryController {

	@Resource
	private SavedQueryService savedQueryService;
	
	/**
	 * 列表
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/list")
	private String list() {
		return "base/savedQuery/list";
	}
	
	/**
	 * 编辑
	 *
	 * @return
	 */
	@RefreshCSRFToken
	@RequestMapping(method = RequestMethod.GET, value = "/edit")
	private String edit(Model model,String id, String url,HttpServletRequest request) {
		request.setAttribute("id", id);
		request.setAttribute("url", url);
		model.addAttribute("url", url);
		return "base/savedQuery/edit";
	}
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/get")
	@ResponseBody
	private SavedQuery get(String id) {
		return savedQueryService.get(SavedQuery.class, id);
	}
	
	@VerifyCSRFToken
	@RequestMapping(method = RequestMethod.POST, value = "/save")
	@ResponseBody
	private Result save(SavedQuery savedQuery, HttpServletRequest request) {
		String id = "";
		Subject subject = SecurityUtils.getSubject();
		if (StrUtil.isEmpty(savedQuery.getId())) {
			savedQuery.setUsername((String)subject.getSession().getAttribute("userName"));
			id = savedQueryService.save(savedQuery).toString();
		} else {
			savedQuery.setUpdateDateTime(new Date());
			savedQueryService.update(savedQuery);
			id = savedQuery.getId();
		}
		return new Result(true);
	}
}
