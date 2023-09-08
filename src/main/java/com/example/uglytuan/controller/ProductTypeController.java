package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.ProductTypeDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.ProductType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/manage/merchant/productType")
public class ProductTypeController
{
    @GetMapping("list")
    public void list(Model model,String pageNum){
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        List<ProductType> productTypeList=ProductTypeDAOImpl.getDao().findAll(pageUtils);
        model.addAttribute("productTypeList",productTypeList);
    }

    @GetMapping("add")
    public void addInit(Model model){

    }

    @PostMapping("add")
    public String add(ProductType productType){
        ProductTypeDAOImpl.getDao().add(productType);
        return "redirect:/manage/merchant/productType/list";
    }

    @PostMapping("delete")
    @ResponseBody
    public String delete(int id){
        ProductTypeDAOImpl.getDao().delete(id);
        return "yes";
    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
        ProductType productType=ProductTypeDAOImpl.getDao().findById(id);
        model.addAttribute("productType",productType);
    }

    @PostMapping("update")
    public String update(ProductType productType){
        ProductTypeDAOImpl.getDao().update(productType);
        return "redirect:/manage/merchant/productType/list";
    }

}
