package com.example.uglytuan.filter;

import com.example.uglytuan.vo.Manager;
import com.example.uglytuan.vo.Rider;
import com.example.uglytuan.vo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/manage/*")
public class ManagerLoginFilter implements Filter
{
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
    {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;

        //如果是登录放行
        String uri = request.getRequestURI();
        if(uri.contains("/manage/manager/managerLogin")){
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        HttpSession session=request.getSession();
        Manager manager=(Manager) session.getAttribute("manager");
        if(manager==null){
            response.sendRedirect(request.getContextPath()+"/manage/manager/managerLogin");
            return;
        }
        //放行
        filterChain.doFilter(request,response);
    }
}

