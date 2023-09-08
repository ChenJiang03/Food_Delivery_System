package com.example.uglytuan.filter;

import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.vo.Merchant;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/MerchantCenter/*")
public class MerchantAutoLoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest)servletRequest;
        HttpServletResponse response=(HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();
        if (session.getAttribute("merchant") != null)
        {
            filterChain.doFilter(request, response);
            return;
        }
        String MerchantUsername=CookieUtils.getCookie("MerchantUsername",request);
        String MerchantPassword=CookieUtils.getCookie("MerchantPassword",request);
        if(MerchantUsername!=null&&!MerchantUsername.equals("")&&MerchantPassword!=null&&!MerchantPassword.equals("")){
            Merchant merchant =MerchantDAOImpl.getDao().findByUserAndPass(MerchantUsername,MerchantPassword);
            if(merchant!=null){
                session.setAttribute("merchant",merchant);
            }
        }
        filterChain.doFilter(request,response);
    }
}
