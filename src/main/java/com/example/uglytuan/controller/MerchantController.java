package com.example.uglytuan.controller;

import com.example.uglytuan.dao.ProductDAO;
import com.example.uglytuan.dao.ProductTypeDAO;
import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.MerchantType;
import com.example.uglytuan.vo.SysArea;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
    @RequestMapping("/manage/merchant")
public class MerchantController
{
    @GetMapping("list")
    public String list(String keywords,String merchantTypeId,Model model,String pageNum,String minTime,String maxTime){
        model.addAttribute("merchantTypeId",merchantTypeId);
        model.addAttribute("keywords",keywords);
        model.addAttribute("minTime",minTime);
        model.addAttribute("maxTime",maxTime);
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        int pid=0;
        try{
            pid=Integer.parseInt(merchantTypeId);
        }
        catch (Exception e){

        }
        List<Merchant> merchantList= MerchantDAOImpl.getDao().search2(keywords,pid,pageUtils,minTime,maxTime);
        List<MerchantType> merchantTypeList= MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantList",merchantList);
        model.addAttribute("merchantTypeList",merchantTypeList);
        return "/manage/merchant/list";
    }

    @GetMapping("add")
    public void addInit(Model model){
        List<MerchantType> merchantTypeList= MerchantTypeDAOImpl.getMerchantType().findAll();
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList",sysAreaList);
        model.addAttribute("merchantTypeList",merchantTypeList);
    }

    @PostMapping("add")
    public String add(Merchant merchant){
        MerchantDAOImpl.getDao().add(merchant);
        return "redirect:/manage/merchant/list";
    }

    @GetMapping("auditList")
    public void auditList(Model model, String pageNum) {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        List<Merchant> merchantList = MerchantDAOImpl.getDao().findAllCheck(pageUtils);
        model.addAttribute("merchantList", merchantList);
        List<MerchantType> merchantTypeList = MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantTypeList", merchantTypeList);
    }

    @GetMapping("audit")
    public void audit(Model model,int id) {
        List<SysArea> sysAreaList = SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList", sysAreaList);
        Merchant merchant = MerchantDAOImpl.getDao().findById(id);
        model.addAttribute("merchant", merchant);
        List<MerchantType> merchantTypeList = MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantTypeList",merchantTypeList);
    }
//
//    @GetMapping("delete")
//    public String delete(int id){
//    }

    @GetMapping("update")
    public void updateInit(int id, Model model) {
        List<SysArea> sysAreaList = SysAreaDAOImpl.getDao().findAll("0");
        List<MerchantType> merchantTypeList = MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("sysAreaList", sysAreaList);
        Merchant merchant = MerchantDAOImpl.getDao().findById(id);
        model.addAttribute("merchant", merchant);
        model.addAttribute("merchantTypeList", merchantTypeList);
    }

    @PostMapping("update")
    public String update(Merchant merchant) {
        MerchantDAOImpl.getDao().update(merchant);
        return "redirect:/manage/merchant/list";
    }


    @PostMapping("uploadPic")
    @ResponseBody
    public String uploadPic(MultipartFile file, HttpServletRequest request) throws IOException {
        String fileName = file.getOriginalFilename();
        if (fileName.trim().length() != 0) {
            int index = fileName.lastIndexOf(".");
            String fileExt = fileName.substring(index);
            String newFileName = UUID.randomUUID().toString();
            newFileName += fileExt;
            String path = request.getServletContext().getRealPath("/img");
            file.transferTo(new File(path + "/" + newFileName));
            return "/img/" + newFileName;
        }
        return "fail";
    }

    @PostMapping("uploadPic2")
    @ResponseBody
    public String uploadPic2(MultipartFile file2, HttpServletRequest request) throws IOException {
        String fileName = file2.getOriginalFilename();
        if (fileName.trim().length() != 0) {
            int index = fileName.lastIndexOf(".");
            String fileExt = fileName.substring(index);
            String newFileName = UUID.randomUUID().toString();
            newFileName += fileExt;
            String path = request.getServletContext().getRealPath("/img");
            file2.transferTo(new File(path + "/" + newFileName));
            return "/img/" + newFileName;
        }
        return "fail";
    }

    @RequestMapping("search")
    public String search(String keywords, Model model,int merchantTypeId,String keyword,String minTime,String maxTime, String pageNum) {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);

        model.addAttribute("merchantTypeId",merchantTypeId);
        model.addAttribute("keyword",keyword);
        model.addAttribute("minTime",minTime);
        model.addAttribute("maxTime",maxTime);
        List<Merchant> merchantList=MerchantDAOImpl.getDao().search(merchantTypeId,keyword,minTime,maxTime);
        model.addAttribute("merchantList",merchantList);
        List<MerchantType> merchantTypeList = MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantTypeList", merchantTypeList);
        return "/manage/merchant/list";
    }

    @RequestMapping("auditOk")
    public String auditOk(Model model,int id){
        MerchantDAOImpl.getDao().auditOk(id);
        return "redirect:/manage/merchant/auditList";
    }

    @RequestMapping("auditNo")
    public String auditNo(Model model,int id){
        MerchantDAOImpl.getDao().delete(id);
        return "redirect:/manage/merchant/auditList";
    }

    @GetMapping("orders")
    public List<Orders> getOrders(@RequestParam("id") Integer id, Model model, String pageNum)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        System.out.println(id);
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByMerchantId(id, pageUtils);
        model.addAttribute("merchant_id", id);
        return ordersList;
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
