package com.example.uglytuan.filter;


import com.example.uglytuan.dao.UserDAO;
import com.example.uglytuan.dao.impl.UserDAOImpl;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.vo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/userCenter/*")
public class UserAutoLoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request=(HttpServletRequest) servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;
        HttpSession session=request.getSession();
        if (session.getAttribute("user") != null)
        {
            chain.doFilter(request, response);
            return;
        }
        String username= CookieUtils.getCookie("username",request);
        String password=CookieUtils.getCookie("password",request);
        if(username!=null&&!username.equals("")&&password!=null&&!password.equals("")){
            User user= UserDAOImpl.getDAO().findByUsernameAndPass(username,password);
            if(user!=null){
                session.setAttribute("user",user);
            }
        }
        chain.doFilter(request, response);
    }

}
