package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.OrderDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/manage/orderDetail")
public class OrderDetailController
{
    @GetMapping("list")
    public void list(Model model, String pageNum,int orderId){
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        List<OrderDetail> orderDetail = OrderDetailDAOImpl.getDAO().findPage(pageUtils,orderId);
        model.addAttribute("orderDetail",orderDetail);

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

    @GetMapping("update")
    public void updateInit(int id, Model model){
    }
}
