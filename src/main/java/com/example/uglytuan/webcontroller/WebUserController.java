package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.UserDAOImpl;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/User")
public class WebUserController {
    @RequestMapping ("login")
    public String login(String username, String password, HttpServletRequest request, String rememberMe, HttpServletResponse response){
        User user = UserDAOImpl.getDAO().findByUsernameAndPass(username, password);
        if(user == null){
            return "/User/login";
        }
        if("on".equals(rememberMe)){
            CookieUtils.addCookie("username",username,"/",7*24*60*60,response);
            CookieUtils.addCookie("password",password,"/",60*60*24*7,response);
        }
        else
        {
            CookieUtils.addCookie("username",username,"/",0,response);
            CookieUtils.addCookie("password",password,"/",0,response);
        }
        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        return "userCenter/index";
    }




    @GetMapping("register")
    public void registerInit(){

    }

    @PostMapping("register")
    public String register(User object){
        UserDAOImpl.getDAO().add(object);
        return "redirect:/User/login";
    }


    @RequestMapping("exist")
    @ResponseBody
    public String existUser(String username,HttpServletResponse response) throws Exception{
        if(UserDAOImpl.getDAO().existUser(username)){
            return "no";
        }else{
            return "ok";
        }

    }


}
