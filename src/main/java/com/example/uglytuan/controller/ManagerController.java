package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.ManagerDAOImpl;
import com.example.uglytuan.dao.impl.UserDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Manager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/manage/manager")
public class ManagerController
{
    @GetMapping("managerLogin")
    public void login(){}

    @PostMapping("managerLogin")
    ModelAndView login(String username, String password, HttpServletRequest request){
        Manager manager = ManagerDAOImpl.getManagerDAO().login(username,password);
        ModelAndView mv= new ModelAndView();
        String error = "error";
        if(manager==null){
            mv.addObject("error",error);
            mv.setViewName("manage/manager/managerLogin");
            return mv;
        }
        HttpSession session = request.getSession();
        session.setAttribute("manager",manager);
        mv.setViewName("manage/manager/index");
        return mv;
    }
    @RequestMapping("index")
    public void index(){}


    @RequestMapping("exit")
    public String exit(HttpSession session){
        session.removeAttribute("manager");
        return "managerLogin";

    }
    @RequestMapping("list")
    public String list(HttpServletRequest request,Model model,String pageNum){
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        List<Manager> managerList = ManagerDAOImpl.getManagerDAO().findAll(pageUtils);
        HttpSession session = request.getSession();
        Manager manager = (Manager) session.getAttribute("manager");
        String msg = "error";
        model.addAttribute("msg",msg);

        if(manager.getSuperManager()){
            model.addAttribute("managerList",managerList);
            return "manage/manager/list";
        }
        else{

            return "redirect:/manage/manager/index";
        }
    }

    @GetMapping("insert")
    public void addInit(){

    }

    @PostMapping("insert")
    public String add(Manager manager){
        ManagerDAOImpl.getManagerDAO().add(manager);
        return "redirect:/manage/manager/list";
    }

    @GetMapping("update")
    public void updateInit(int id,Model model){
        Manager manager = ManagerDAOImpl.getManagerDAO().findById(id);
        model.addAttribute("manager",manager);
    }

    @PostMapping("update")
    public String update(Manager manager){
        ManagerDAOImpl.getManagerDAO().update(manager);
        return "redirect:/manage/manager/list";
    }

    @RequestMapping("search")
    public String search(String keywords,Model model,String pageNum){
        PageUtils pageUtils=PageUtils.init(pageNum,model);

        List<Manager> managerList = ManagerDAOImpl.getManagerDAO().search(keywords,pageUtils);

        model.addAttribute("managerList",managerList);
        return "manage/manager/list";
    }

    @RequestMapping("exist")
    @ResponseBody
    public String existManager(String username, HttpServletResponse response) throws Exception{
        if(ManagerDAOImpl.getManagerDAO().existManager(username)){
            return "no";
        }else{
            return "ok";
        }

    }

}
