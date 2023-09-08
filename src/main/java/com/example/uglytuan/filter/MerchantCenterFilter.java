package com.example.uglytuan.filter;

import com.example.uglytuan.vo.Merchant;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/MerchantCenter/*")
public class MerchantCenterFilter implements Filter {


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse)servletResponse;
        HttpSession session= request.getSession();
        Merchant merchant=(Merchant)session.getAttribute("merchant");
        if(merchant==null){
            response.sendRedirect(request.getContextPath()+"/Merchant/login");
            return;
        }
        filterChain.doFilter(request,response);
    }
}
