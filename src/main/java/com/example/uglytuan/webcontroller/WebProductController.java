package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.dao.impl.ProductDAOImpl;
import com.example.uglytuan.dao.impl.ProductTypeDAOImpl;
import com.example.uglytuan.vo.Merchant;
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
@RequestMapping("/MerchantCenter/product")
public class WebProductController {

    @GetMapping("list")
    public void list(int id, Model model){
        List<Product> productList=ProductDAOImpl.getDao().findByMerchantId(id);
        model.addAttribute("productList",productList);
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("productTypeList",productTypeList);
    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
        Product product=ProductDAOImpl.getDao().findById(id);
        model.addAttribute("product",product);
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("productTypeList",productTypeList);
    }

    @GetMapping("add")
    public void addInit(Model model){
        List<ProductType> productTypeList= ProductTypeDAOImpl.getDao().findAll();
        model.addAttribute("productTypeList",productTypeList);
    }

    @PostMapping("add")
    public String add(Product product){
        ProductDAOImpl.getDao().add(product);
        return "redirect:/MerchantCenter/product/list?id="+product.getMerchantId();
    }


    @PostMapping("update")
    public String update(int id,int sid,Product product){
        ProductDAOImpl.getDao().updateById(product);

        return "redirect:/MerchantCenter/product/list?id="+sid;
    }

    @PostMapping("delete")
    @ResponseBody
    public String delete(int id){
        ProductDAOImpl.getDao().delete(id);
        return "yes";
    }

}
