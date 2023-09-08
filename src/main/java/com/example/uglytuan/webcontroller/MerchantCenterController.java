package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("MerchantCenter")
public class MerchantCenterController {

    @RequestMapping("exit")
    public String exit(HttpSession session, HttpServletResponse response){
        session.removeAttribute("merchant");
        CookieUtils.addCookie("MerchantUsername",null,"/",0,response);
        CookieUtils.addCookie("MerchantPassword",null,"/",0,response);
        return "redirect:/Merchant/login";
    }

    @GetMapping("index")
    public void index(){

    }

    @GetMapping("update")
    public void updateInfo(Model model){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList",sysAreaList);
        List<MerchantType> merchantTypeList= MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantTypeList",merchantTypeList);
    }

    @PostMapping("update")
    public String update(Merchant merchant, HttpSession session){
        MerchantDAOImpl.getDao().updateCenter(merchant);
        Merchant merchant1=MerchantDAOImpl.getDao().findById(merchant.getId());
        session.setAttribute("merchant",merchant1);
        return "redirect:/MerchantCenter/index";
    }

    @GetMapping("updatePass")
    public void updatePassInfo(){

    }

    @PostMapping("updatePass")
    public String updatePass(Merchant merchant,HttpSession session){
        MerchantDAOImpl.getDao().updatePass(merchant);
        session.removeAttribute("merchant");
        return "redirect:/Merchant/login";
    }
    @GetMapping("orders/list")
    public List<Orders> listOrders(HttpSession session, Model model, String pageNum)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByMerchantId(merchant.getId(), pageUtils);
        return ordersList;
    }

    /*
   加了排序的方法
    */
    @GetMapping("orders/showList")
    public String showListOrdersByCondition(String pageNum, Model model, String keywords, HttpSession session)
    {
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils, "merchant", merchant.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "MerchantCenter/orders/list";
    }

    @PostMapping("orders/list")
    public String listOrdersByCondition(String pageNum, HttpSession session, Model model, String keywords)
    {
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils,"merchant", merchant.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "MerchantCenter/orders/list";
    }

    @GetMapping("orders/newOrders")
    public List<Orders> listNewOrders(HttpSession session, Model model, String pageNum)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByMerchantIdAndUserFlag(merchant.getId(), pageUtils);
        return ordersList;
    }

    @GetMapping("orders/ordersInfo")
    public Orders ordersInfo(@RequestParam("id") Integer id, Model model)
    {
        Orders orders = OrdersDAOImpl.getDao().findById(id);
        List<OrderDetail> orderDetails = OrderDetailDAOImpl.getDAO().findByOrderId(id);
        model.addAttribute("orderDetails", orderDetails);
        System.out.println(orders.getMerchantProvince().getName());
        System.out.println(orders.getMerchantCity().getName());
        System.out.println(orders.getMerchantDistrict().getName());
        return orders;
    }

    @RequestMapping("orders/orderStatus")
    public String orderStatus(@RequestParam("order_status") Integer order_status, HttpSession session, String pageNum, Model model)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        List<Orders>  ordersList= OrdersDAOImpl.getDao().findByOrderStatus(order_status, merchant.getId(),"merchant", pageUtils);
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("order_status", order_status);
        return "/MerchantCenter/orders/orderStatus";
    }

    @RequestMapping("orders/accept")
    public String acceptOrder(@RequestParam("id") Integer id, HttpSession session)
    {
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        OrdersDAOImpl.getDao().distributeOrders(id, merchant.getDistrictId());
        OrdersDAOImpl.getDao().updateMerchantFlag(id);
        return "redirect:/MerchantCenter/orders/newOrders";
    }

    @RequestMapping("orders/cancel")
    public String cancelOrder(@RequestParam("id") Integer id)
    {
        OrdersDAOImpl.getDao().cancelOrder(id);
        return "redirect:/MerchantCenter/orders/newOrders";
    }

    @GetMapping("recharge")
    public void rechargeInit(){ }

    @PostMapping("recharge")
    public String recharge(Double balance,int id,HttpSession session){
        MerchantDAOImpl.getDao().recharge(balance,id);
        Merchant merchant=MerchantDAOImpl.getDao().findById(id);
        session.setAttribute("merchant",merchant);
        return "redirect:/MerchantCenter/index";

    }

}
