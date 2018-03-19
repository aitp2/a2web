package com.monitor.framework.base.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.monitor.framework.base.entity.UserAvatar;
import com.monitor.framework.utils.StrUtil;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.monitor.framework.annotation.RefreshCSRFToken;
import com.monitor.framework.annotation.VerifyCSRFToken;
import com.monitor.framework.base.entity.User;
import com.monitor.framework.base.pojo.PageInfo;
import com.monitor.framework.base.pojo.Result;
import com.monitor.framework.base.service.UserService;

@Controller
@RequestMapping(value = "/buniess")
public class BusinessController {

    @RequestMapping(method = RequestMethod.GET, value = "/overview")
    private String list() {

        return "poc/businessoverview";
    }

}
