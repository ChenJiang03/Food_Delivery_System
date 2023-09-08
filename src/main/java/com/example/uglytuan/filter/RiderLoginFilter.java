package com.example.uglytuan.filter;

import com.example.uglytuan.vo.Rider;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/riderCenter/*")
public class RiderLoginFilter implements Filter
{
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
    {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;

        //如果是登录放行
        String uri = request.getRequestURI();
        if(uri.contains("/riderCenter/login") || uri.contains("/riderCenter/register") || uri.contains("/riderCenter/existRider") || uri.contains("/riderCenter/address")){
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        HttpSession session=request.getSession();
        Rider rider=(Rider) session.getAttribute("rider");
        if(rider==null){
            response.sendRedirect(request.getContextPath()+"/riderCenter/login");
            return;
        }
        //放行
        filterChain.doFilter(request,response);
    }
}
