package com.monitor.framework.base.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.monitor.framework.base.service.SavedQueryService;

@Controller
public class MainController {

    Logger logger = Logger.getLogger(MainController.class);
    
	@Resource
	private SavedQueryService savedQueryService;

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public String index(Model model,HttpServletRequest request) {
    	Subject subject = SecurityUtils.getSubject();
    	model.addAttribute("savedQueryList", savedQueryService.getSavedQueryByUsername((String)subject.getSession().getAttribute("userName")));
        return "main";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/main")
    public String main(HttpServletRequest request) {

        return "main";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/homePage")
    public String homePage(HttpServletRequest request) {

        return "homePage";
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/jsonformat")
    public String jsonformat(HttpServletRequest request) {

        return "tool/jsonformat";
    }


}
