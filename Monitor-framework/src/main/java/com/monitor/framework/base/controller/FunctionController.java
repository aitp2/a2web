package com.monitor.framework.base.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.monitor.framework.base.entity.Function;
import com.monitor.framework.base.pojo.Result;
import com.monitor.framework.base.pojo.TreeNode;
import com.monitor.framework.base.service.FunctionService;
import com.monitor.framework.utils.StrUtil;

@Controller
@RequestMapping(value = "/function")
public class FunctionController {

    @Resource
    private FunctionService functionService;

    /**
     * 用户列表
     */
    @RequestMapping(method = RequestMethod.GET, value = "/tree")
    private String list() {

        return "base/auth/function_tree";
    }

    @RequestMapping(value = "/all", method = RequestMethod.POST)
    @ResponseBody
    public List<Function> getAll() {
    	
        return functionService.getAll();
    }
    
    @RequestMapping(value = "/auth_all", method = RequestMethod.POST)
    @ResponseBody
    public List<Function> getAuthAll() {

    	Subject subject = SecurityUtils.getSubject();
    	String username = (String) subject.getSession().getAttribute("userName");
    	StringBuilder strb = new StringBuilder();
    	strb.append("SELECT * FROM tbl_function ");
    	strb.append("INNER JOIN tbl_role_function ON tbl_function.id = tbl_role_function.functionId ");
    	strb.append("INNER JOIN tbl_user_role ON tbl_role_function.roleId = tbl_user_role.roleId ");
    	strb.append("INNER JOIN tbl_user ON tbl_user.id = tbl_user_role.userId ");
    	strb.append("WHERE tbl_user.login_name = " + "\'" + username + "\'");
    	List<Function> lstFunc = functionService.findBySql(strb.toString(), Function.class);
        return lstFunc;
    }

    /**
     * getTreeData 构造bootstrap-treeview格式数据
     *
     * @return
     */
    @RequestMapping(value = "/treeData", method = RequestMethod.POST)
    @ResponseBody
    public List<TreeNode> getTreeData() {

        return functionService.getTreeData();
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Function get(@PathVariable("id") String id) {

        Function function = functionService.get(Function.class, id);
        if (!StrUtil.isEmpty(function.getParentId())) {
            function.setParentName(functionService.get(Function.class, function.getParentId()).getName());
        } else {
            function.setParentName("系统菜单");
        }
        return function;
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(Function function) {

        function.setUpdateDateTime(new Date());
        functionService.saveOrUpdate(function);
        return new Result(true);
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@PathVariable("id") String id) {

        try {
            Function function = functionService.get(Function.class, id);
            functionService.delete(function);
            return new Result(true);
        } catch (Exception e) {
            return new Result(false, "该菜单/功能已经被其他数据引用，不可删除");
        }
    }


    //TODO 功能集合将从session中获取
    @RequestMapping(value="/navigation")
    @ResponseBody
    public List<Function> navigation(String pageUrl){
        return  functionService.getAll();
    }


}
