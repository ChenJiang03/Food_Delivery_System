package com.example.uglytuan.webcontroller;


import com.example.uglytuan.dao.ProductDAO;
import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.dao.impl.MerchantTypeDAOImpl;
import com.example.uglytuan.dao.impl.ProductTypeDAOImpl;
import com.example.uglytuan.dao.impl.SysAreaDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/userCenter")
public class WebListController {

    @RequestMapping("list")
    public void listInit(Model model){
        List<Merchant> merchantList = MerchantDAOImpl.getDao().findAll();
        List<MerchantType> merchantTypeList = MerchantTypeDAOImpl.getMerchantType().findAll();
        List<ProductType> productTypeList = ProductTypeDAOImpl.getDao().findAll();
        List<SysArea> sysAreaList = SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("merchantList",merchantList);
        model.addAttribute("sysAreaList",sysAreaList);
        model.addAttribute("merchantTypeList",merchantTypeList);
        model.addAttribute("productTypeList",productTypeList);
    }

    @GetMapping("list/search")
    @ResponseBody
    public List<Merchant> list(int districtId,int merchantTypeId){
        List<Merchant> merchantList = MerchantDAOImpl.getDao().search(districtId,merchantTypeId);
        return merchantList;

    }

    @GetMapping("list/getList")
    @ResponseBody
    public List<Merchant> getList(int pageNum){
        PageUtils pageUtils=new PageUtils();
        pageUtils.setPageNum(pageNum);
        pageUtils.setPageSize(4);
        List<Merchant> merchantList = MerchantDAOImpl.getDao().findAll(pageUtils);
        return merchantList;
    }

    @GetMapping("search")
    @ResponseBody
    public List<Merchant> search(String keywords){
        System.out.println("search..........");
        List<Merchant> merchantList = MerchantDAOImpl.getDao().search3(keywords);
        return merchantList;
    }

    @GetMapping("list/searchByTime")
    @ResponseBody
    public List<Merchant> searchByTime(){
        List<Merchant> merchantList = MerchantDAOImpl.getDao().findByTime();
        return merchantList;
    }

    @GetMapping("list/searchByDefault")
    @ResponseBody
    public List<Merchant> searchByDefault(){
        List<Merchant> merchantList = MerchantDAOImpl.getDao().findAll();
        return merchantList;
    }

}
