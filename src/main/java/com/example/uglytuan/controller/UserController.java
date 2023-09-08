package com.example.uglytuan.controller;
import com.example.uglytuan.dao.impl.AddressDAOImpl;
import com.example.uglytuan.dao.impl.SysAreaDAOImpl;
import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.dao.impl.OrdersDAOImpl;
import com.example.uglytuan.dao.impl.AddressDAOImpl;
import com.example.uglytuan.dao.impl.SysAreaDAOImpl;
import com.example.uglytuan.dao.impl.UserDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/manage/user")
public class UserController
{
    @RequestMapping ("list")
    public void list(Model model, String pageNum) {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
//        List<User> userList = UserDAOImpl.getDAO().findAll();
//        model.addAttribute("userList", userList);
        List<User> userList = UserDAOImpl.getDAO().findPage(pageUtils);
        model.addAttribute("userList", userList);

    }

    @GetMapping("add")
    public void addInit(Model model){
    }

    @PostMapping("add")
    public String add(String username,String password,String name,String phone,String address){
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setAddress(address);
        UserDAOImpl.getDAO().add(user);
        return "redirect:/manage/user/list";
    }

    @PostMapping("existUser")
    @ResponseBody
    public String existUser(String username){
        if(UserDAOImpl.getDAO().existUser(username)){
            return "yes";

        }else{
            return "no";
        }
    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
        User user = UserDAOImpl.getDAO().findById(id);
        model.addAttribute("user",user);
    }

    @PostMapping("update")
    public String update(User user) {
        UserDAOImpl.getDAO().update(user);
        return "redirect:/manage/user/list";
    }

    @PostMapping("uploadPic")
    @ResponseBody
    public String uploadPic( HttpServletRequest request, MultipartFile file) throws IOException {
        String fileName = file.getOriginalFilename();
        if(fileName.trim().length()!=0){
            int index = fileName.lastIndexOf(".");
            String fileExt = fileName.substring(index);
            String newFileName = UUID.randomUUID().toString();
            newFileName =  newFileName+fileExt;
//获得当前项目的运行路径
            String path = request.getServletContext().getRealPath("/img");
// 将图片存入文件夹
            file.transferTo(new File(path+"/"+newFileName));
            return "/img/"+newFileName;

        }

        return "fail";

    }


    @RequestMapping("search")
    public String search( Model model,String keywords,String pageNum){
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<User> userList = UserDAOImpl.getDAO().searchUser(keywords,pageUtils);
        model.addAttribute("userList",userList);
        return "/manage/user/list";
    }

    @GetMapping("orders")
    public List<Orders> getOrders(@RequestParam("id") Integer id, Model model, String pageNum)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        System.out.println(id);
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByUserId(id, pageUtils);
        model.addAttribute("user_id", id);
        return ordersList;
    }

    @GetMapping("ordersInfo")
    public Orders ordersInfo(@RequestParam("id") Integer id, Model model)
    {
        System.out.println(id);
        Orders orders = OrdersDAOImpl.getDao().findById(id);
        List<OrderDetail> orderDetails = OrderDetailDAOImpl.getDAO().findByOrderId(id);
        model.addAttribute("orderDetails", orderDetails);

        return orders;
    }
    @GetMapping("getSysArea")
    @ResponseBody
    public List<SysArea> getSysArea(String id){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll(id);
        return sysAreaList;
    }

    @GetMapping("userAddress")
    public void userAddress(Model model,int userId,String pageNum){


        PageUtils pageUtils = PageUtils.init(pageNum,model);

        List<Address> addressList = AddressDAOImpl.getDao().findAll(userId,pageUtils);

        model.addAttribute("addressList",addressList);



    }

//    }
//=========
//    @GetMapping("orders")
//    public List<Orders> getOrders(@RequestParam("id") Integer id)
//    {
//        System.out.println(id);
//        List<Orders> ordersList = OrdersDAOImpl.getDao().findByUserId(id);
//        return ordersList;
//    }

//    @GetMapping("ordersInfo")
//    public Orders ordersInfo(@RequestParam("id") Integer id, Model model)
//    {
//        System.out.println(id);
//        Orders orders = OrdersDAOImpl.getDao().findById(id);
//        List<OrderDetail> orderDetails = OrderDetailDAOImpl.getDAO().findByOrderId(id);
//        model.addAttribute("orderDetails", orderDetails);
//
//        return orders;
//    }
//>>>>>>>>> Temporary merge branch 2

}
