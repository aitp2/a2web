package com.monitor.framework.filter;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
/**
 *
 *
 */
public class SystemFilter implements Filter {
	
	String resourcePath = "";

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException,
            ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        System.out.println("SystemFilter begin time:"+new Date()+request.getRequestURL());
        String basePath = request.getContextPath();
        request.setAttribute("basePath", basePath);
        request.setAttribute("resourcePath", resourcePath);
        request.setAttribute("username", request.getSession().getAttribute("userName"));
        filterChain.doFilter(request, servletResponse);
        System.out.println("SystemFilter finish time:"+new Date()+request.getRequestURL());
    }

    @Override
    public void destroy() {

        // TODO Auto-generated method stub

    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
    	resourcePath=arg0.getInitParameter("resourcePath");
    }
    
    public static void main(String[] args) {
    	System.out.println("time:"+new Date());
    }

}
