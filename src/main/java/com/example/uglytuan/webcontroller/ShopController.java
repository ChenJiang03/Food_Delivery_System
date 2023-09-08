package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.dao.impl.ProductDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/userCenter")
public class ShopController {
    @RequestMapping("shop")
    public String findMerchant(int id, Model model,String pageNum){
        PageUtils pageUtils = PageUtils.init(pageNum,model);
        Merchant merchant = MerchantDAOImpl.getDao().findById(id);
        pageUtils.setPageSize(4);
        List<Product> productList = ProductDAOImpl.getDao().findByMerchantId(id,pageUtils);
        model.addAttribute("productList",productList);
        model.addAttribute("merchant",merchant);
        return "/userCenter/shop";
    }
}
