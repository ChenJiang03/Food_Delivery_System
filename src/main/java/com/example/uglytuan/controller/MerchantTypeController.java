package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.MerchantTypeDAOImpl;
import com.example.uglytuan.dao.impl.ProductTypeDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.MerchantType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/manage/merchant/merchantType")
public class MerchantTypeController
{
    @GetMapping("list")
    public void list(Model model,String pageNum){
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        List<MerchantType> merchantTypeList=MerchantTypeDAOImpl.getMerchantType().findAll(pageUtils);
        model.addAttribute("merchantTypeList",merchantTypeList);
    }

    @GetMapping("add")
    public void addInit(Model model){
    }

    @PostMapping("add")
    public String add(MerchantType merchantType){
        MerchantTypeDAOImpl.getMerchantType().add(merchantType);
        return "redirect:/manage/merchant/merchantType/list";
    }

    @PostMapping("delete")
    @ResponseBody
    public String delete(int id){
        MerchantTypeDAOImpl.getMerchantType().delete(id);
        return "yes";
    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
        MerchantType merchantType=MerchantTypeDAOImpl.getMerchantType().findById(id);
        model.addAttribute("merchantType",merchantType);
    }

    @PostMapping("update")
    public String update(MerchantType merchantType){
        MerchantTypeDAOImpl.getMerchantType().update(merchantType);
        return "redirect:/manage/merchant/merchantType/list";

    }
}
