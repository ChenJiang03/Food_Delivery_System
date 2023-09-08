package com.example.uglytuan.filter;

import com.example.uglytuan.vo.Rider;
import com.example.uglytuan.vo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/userCenter/*")
public class UserLoginFilter implements Filter
{
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
    {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;

        //如果是登录放行
        String uri = request.getRequestURI();
        if(uri.contains("/userCenter/login") || uri.contains("/userCenter/register") || uri.contains("/userCenter/existUser")||uri.contains("/userCenter/list")
                ||uri.contains("/userCenter/shop")||uri.contains("/userCenter/search")||uri.contains("/userCenter/address/getSysArea")
                ||uri.contains("/userCenter/list/search")
        ){
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        HttpSession session=request.getSession();
        User user=(User) session.getAttribute("user");
        if(user==null){
            response.sendRedirect(request.getContextPath()+"/User/login");
            return;
        }
        //放行
        filterChain.doFilter(request,response);
    }
}
