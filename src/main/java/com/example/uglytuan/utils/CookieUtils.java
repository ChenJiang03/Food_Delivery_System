package com.example.uglytuan.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {
    public static void addCookie(String name, String value, String path, int maxAge, HttpServletResponse response){
        Cookie cookie=new Cookie(name,value);
        cookie.setPath(path);
        cookie.setMaxAge(maxAge);
        response.addCookie(cookie);
    }

    public static String getCookie(String name, HttpServletRequest request){
        Cookie[] cookies=request.getCookies();
        if(cookies==null){
            return null;
        }
        for (Cookie cookie:cookies){
            if(cookie.getName().equals(name)){
                return cookie.getValue();
            }
        }
        return null;
    }
}
