package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.ProductDAOImpl;
import com.example.uglytuan.vo.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/userCenter/product")
public class ListProductController {

    @RequestMapping("details")
    public String productDetails(int id, Model model){
        Product product = ProductDAOImpl.getDao().findById(id);
        model.addAttribute("product",product);
        return "/userCenter/product/details";
    }





}
