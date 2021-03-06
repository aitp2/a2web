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
@RequestMapping(value = "/user")
public class UserController {

    @Resource
    private UserService userService;

    /**
     * 用户列表
     */
    @RequestMapping(method = RequestMethod.GET, value = "/list")
    private String list() {

        return "base/user/user_list";
    }

    /**
     * 用户编辑
     *
     * @return
     */
    @RefreshCSRFToken
    @RequestMapping(method = RequestMethod.GET, value = "/edit")
    private String edit(String id, HttpServletRequest request) {

        request.setAttribute("id", id);
        return "base/user/user_edit";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    private User getUser(String id) {

        return userService.get(User.class, id);
    }

    @VerifyCSRFToken
    @RequestMapping(method = RequestMethod.POST, value = "/save")
    @ResponseBody
    private Result saveUser(User user, HttpServletRequest request) {
        if (StrUtil.isEmpty(user.getId())) {
            String userId = userService.save(user).toString();
            //头像和用户管理
            userService.updateUserAvatar(user, request.getRealPath("/"));
        } else {
            user.setUpdateDateTime(new Date());
            userService.update(user);
        }
        return new Result(true);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/delete/{id}")
    @ResponseBody
    private Result deleteUser(@PathVariable("id") String id) {

        User user = userService.get(User.class, id);
        try {
            userService.delete(user);
        } catch (Exception e) {
            return new Result(false);
        }
        return new Result(true);
    }

    /**
     * loadData
     *
     * @param pInfo
     * @param conditions
     * @return
     */
    @RequestMapping(method = RequestMethod.POST, value = "/loadData")
    @ResponseBody
    public Map<String, Object> loadData(String pInfo, String conditions) {

        Map<String, Object> map = new HashMap<String, Object>();
        PageInfo pageInfo = JSON.parseObject(pInfo, PageInfo.class);
        DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
        pageInfo.setCount(userService.getCountByCriteria(criteria));
        map.put("pageInfo", pageInfo);
        map.put("data", userService.getListByCriteria(criteria, pageInfo));
        return map;
    }

    /**
     * tab方式curd demo
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET, value = "/tab/list")
    private String tablist() {

        return "base/user/user_tab_list";
    }


    /**
     * 新的页面打开 curd demo
     */
    @RequestMapping(method = RequestMethod.GET, value = "/page/list")
    private String pagelist(String id, HttpServletRequest request) {
        request.setAttribute("selectId", id);
        return "base/user/user_page_list";
    }

    /**
     * 用户编辑 new page
     *
     * @return
     */
    @RefreshCSRFToken
    @RequestMapping(method = RequestMethod.GET, value = "/page/edit")
    private String pageEdit(String id, HttpServletRequest request) {

        request.setAttribute("id", id);
        return "base/user/user_page_edit";
    }

    /**
     * 用户头像上传 avatar
     */
    @RequestMapping(method = RequestMethod.GET, value = "/avatar")
    private String avatar(String userId, HttpServletRequest request) {
        request.setAttribute("userId", userId);
        return "base/user/user_avatar";
    }


    @RequestMapping(method = RequestMethod.POST, value = "/getAvatar")
    @ResponseBody
    private UserAvatar getAvatar(String userId) {
        return userService.getAvatarByUserId(userId);
    }


}
