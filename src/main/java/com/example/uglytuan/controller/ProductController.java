package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.ProductDAOImpl;
import com.example.uglytuan.dao.impl.ProductTypeDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Product;
import com.example.uglytuan.vo.ProductType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/manage/merchant/product")
public class ProductController
{
    @GetMapping("list")
    public void list(int id,Model model,String pageNum){
        int sid=id;
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        List<Product> productList= ProductDAOImpl.getDao().findByMerchantId(id,pageUtils);
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("productList",productList);
        model.addAttribute("sid",sid);
        model.addAttribute("productTypeList",productTypeList);
    }

    @GetMapping("add")
    public void addInit(Model model,int id){
        int merchantId=id;
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("merchantId",merchantId);
        model.addAttribute("productTypeList",productTypeList);
    }

    @PostMapping("add")
    public String add(Product product){
        ProductDAOImpl.getDao().add(product);
        return "redirect:/manage/merchant/product/list?id="+product.getMerchantId();
    }
//
//    @GetMapping("delete")
//    public String delete(int id){
//    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
        Product product=ProductDAOImpl.getDao().findById(id);
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("product",product);
        model.addAttribute("productTypeList",productTypeList);
    }

    @PostMapping("update")
    public String update(Product product){
        ProductDAOImpl.getDao().updateById(product);
        return "redirect:/manage/merchant/product/list?id="+product.getMerchantId();
    }

    @PostMapping("delete")
    @ResponseBody
    public String delete(int id){
        ProductDAOImpl.getDao().delete(id);
        return "yes";
    }
}
