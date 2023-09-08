package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.dao.impl.OrdersDAOImpl;
import com.example.uglytuan.dao.impl.UserDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.OrderDetail;
import com.example.uglytuan.vo.Orders;
import com.example.uglytuan.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/manage/orders")
public class OrdersController
{
    @GetMapping("list")
    public void list(Model model, String pageNum) {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        List<Orders> ordersList = OrdersDAOImpl.getDao().findPage(pageUtils);
        model.addAttribute("ordersList",ordersList);
    }
    @GetMapping("add")
    public void addInit(Model model){
    }

//    @PostMapping("add")
//    public String add(Product product){
//    }
//
//    @GetMapping("delete")
//    public String delete(int id){
//    }

    @RequestMapping("updateInit")
    @ResponseBody
    public int Init(int orderId, Model model){
        return OrdersDAOImpl.getDao().findById(orderId).getRiderFlag();
    }

    @GetMapping("update")
    public void updateInit(int orderId, Model model){
        Orders orders = OrdersDAOImpl.getDao().findById(orderId);
        model.addAttribute("order",orders);
    }
    @PostMapping("update")
    public String updateOrders(Orders order){
        OrdersDAOImpl.getDao().updateTwo(order);
        return "redirect:/manage/orders/list";

    }


    @RequestMapping("search")
    public String search( Model model,String keywords,String pageNum){
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        List<Orders> ordersList =OrdersDAOImpl.getDao().searchOrders(keywords,pageUtils);
        model.addAttribute("ordersList",ordersList);
        return "/manage/orders/list";
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
}
