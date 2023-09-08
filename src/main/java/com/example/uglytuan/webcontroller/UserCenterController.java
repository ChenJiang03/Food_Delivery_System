package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.AddressDAO;
import com.example.uglytuan.dao.SysAreaDAO;
import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/userCenter")
public class UserCenterController {

    @RequestMapping("index")
    public void center(){

    }

    @RequestMapping("exit")
    public String exit(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        CookieUtils.addCookie("username",null,"/",0,response);
        CookieUtils.addCookie("password",null,"/",0,response);
        return "redirect:/User/login";
    }

    @GetMapping("recharge")
    public void rechargeInit(){ }

    @PostMapping("recharge")
    public String recharge(Double balance,int id,HttpSession session){
        UserDAOImpl.getDAO().recharge(balance,id);
        User user = UserDAOImpl.getDAO().findById(id);
        session.setAttribute("user",user);
        return "redirect:/userCenter/index";

    }

    @GetMapping("userManage/updateInfo")
    public void updateInit(){

    }

    @PostMapping("userManage/updateInfo")
    public String update(User user, HttpSession session){
        UserDAOImpl.getDAO().update(user);
        User user1 = UserDAOImpl.getDAO().findById(user.getId());
        session.setAttribute("user", user1);
        return "redirect:/userCenter/index";
    }


    @GetMapping("userManage/updatePassword")
    public void updatePasswordInit(){

    }

    @PostMapping("userManage/updatePassword")
    public String updatePassword(String newPassword,HttpServletRequest request,User user){
        HttpSession session = request.getSession();
        user = (User) session.getAttribute("user");
        user.setPassword(newPassword);
        UserDAOImpl.getDAO().updatePassword(user);
        return "redirect:/User/login";
    }

    @RequestMapping("userManage/uploadPic")
    @ResponseBody
    public String updatePic(MultipartFile file, HttpServletRequest request) throws Exception{
        String fileName=file.getOriginalFilename();
        if(fileName.trim().length()!=0){
            int index=fileName.lastIndexOf(".");
            String fileExt=fileName.substring(index);
            String newFileName= UUID.randomUUID().toString();
            newFileName+=fileExt;
            String path=request.getServletContext().getRealPath("/img");
            file.transferTo(new File(path+"/"+newFileName));
            return "/img/"+newFileName;
        }
        return "fail";
    }


    @GetMapping("address/add")
    public List<SysArea> addAddress(){
        //默认名字 vo类首字母小写+List
        List<SysArea> sysAreaList = SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }

    @GetMapping("address/getSysArea")
    @ResponseBody
    public List<SysArea> getSysArea(String id){
        List<SysArea> sysAreaList = SysAreaDAOImpl.getDao().findAll(id);
        return sysAreaList;
    }

    @PostMapping("address/add")
    public String addAddress(Address address,HttpSession session){
        User user=(User)session.getAttribute("user");
        address.setUser(user);
        if(address.getIsDefault()==null){
            address.setDefault(false);
        }
        else{
            AddressDAOImpl.getDao().resetDefaultAddress();
        }
        AddressDAOImpl.getDao().add(address);
        return "redirect:/userCenter/address/list";
    }

    @GetMapping("address/list")
    public List<Address> addressList(HttpSession session,String pageNum,Model model){
        PageUtils pageUtils=PageUtils.init(pageNum,model);

        User user=(User)session.getAttribute("user");
        List<Address> addressList=AddressDAOImpl.getDao().findAll(user.getId(),pageUtils);
        return addressList;
    }

    @GetMapping("address/update")
    public void updateAddress(Model model, int id){
        //默认名字 vo类首字母小写+List
        List<SysArea> sysAreaList=SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList",sysAreaList);
        Address address=AddressDAOImpl.getDao().findById(id);
        model.addAttribute("address",address);
    }

    @PostMapping("address/update")
    public String updateAddress(Address address){
        if(address.getIsDefault()==null){
            address.setDefault(false);
        }
        else{
            AddressDAOImpl.getDao().resetDefaultAddress();
        }
        AddressDAOImpl.getDao().update(address);
        return "redirect:/userCenter/address/list";
    }

    @GetMapping("address/setDefaultAddress")
    public String setDefaultAddress(int id){
        AddressDAOImpl.getDao().resetDefaultAddress();
        AddressDAOImpl.getDao().setDefaultAddress(id);
        return "redirect:/userCenter/address/list";
    }

    @RequestMapping("address/delete")
    @ResponseBody
    public String delete(int id){
        if(AddressDAOImpl.getDao().delete(id)){
            return "success";
        }
        return "fail";
    }

    @GetMapping("orders/list")
    public List<Orders> listOrders(HttpSession session, Model model, String pageNum)
    {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        User user = (User) session.getAttribute("user");
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByUserId(user.getId(), pageUtils);
        return ordersList;
    }

    @GetMapping("orders/showList")
    public String showListOrdersByCondition(String pageNum, HttpSession session, Model model, String keywords)
    {
        User user = (User) session.getAttribute("user");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils,"user", user.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "userCenter/orders/list";
    }

    @PostMapping("orders/list")
    public String listOrdersByCondition(String pageNum, HttpSession session, Model model, String keywords)
    {
        User user = (User) session.getAttribute("user");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils,"user", user.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "userCenter/orders/list";
    }

    @RequestMapping("orders/orderStatus")
    public String orderStatus(@RequestParam("order_status") Integer order_status, HttpSession session, String pageNum, Model model)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        User user = (User) session.getAttribute("user");
        List<Orders>  ordersList= OrdersDAOImpl.getDao().findByOrderStatus(order_status, user.getId(),"user", pageUtils);
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("order_status", order_status);
        return "/userCenter/orders/orderStatus";
    }

    @GetMapping("orders/ordersInfo")
    public Orders ordersInfo(@RequestParam("id") Integer id, Model model)
    {
        Orders orders = OrdersDAOImpl.getDao().findById(id);
        List<OrderDetail> orderDetails = OrderDetailDAOImpl.getDAO().findByOrderId(id);
        model.addAttribute("orderDetails", orderDetails);
        return orders;
    }


    @RequestMapping("orders/cancel")
    public String cancelOrder(@RequestParam("id") Integer id)
    {
        OrdersDAOImpl.getDao().cancelOrder(id);
        return "redirect:/userCenter/orders/list";
    }
}
