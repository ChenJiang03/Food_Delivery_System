package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/manage/common")
public class CommonController
{
    @GetMapping("list")
    public void list(Model model){
    }

    @GetMapping("add")
    public void addInit(Model model){
    }

//    @PostMapping("add")
//    public String add(Product product){
//    }
//
    @PostMapping("delete")
    @ResponseBody
    public String delete(int id, @RequestParam("dataType") String dataType){
        switch (dataType)
        {
            case "rider":
                if(RiderDAOImpl.getRiderDAO().delete(id))
                {
                    return "success";
                }
                break;
            case "user":
                if(UserDAOImpl.getDAO().delete(id))
                {
                    return "success";
                }
                break;
            case "merchant":
                if(MerchantDAOImpl.getDao().delete(id))
                {
                    return "success";
                }
                break;
            case "manager":
                if(ManagerDAOImpl.getManagerDAO().delete(id))
                {
                    return "success";
                }
                break;
            case "orders":
                if(OrdersDAOImpl.getDao().delete(id))
                {
                    return "success";
                }
                break;
            case "product":
                if(ProductDAOImpl.getDao().delete(id))
                {
                    return "success";
                }
                break;
            case "productType":
                if(ProductTypeDAOImpl.getDao().delete(id))
                {
                    return "success";
                }
                break;
        }
        return "fail";
    }

    /*
    ����������String ids - �Զ��ŷָ��id�ַ���������Ҫ����ɾ����id
            String dataType - ������Ҫ����ɾ����vo������
    �������ܣ�����ÿ��vo���daoʵ��ͳһ����ɾ��
     */
    @PostMapping("batchDel")
    @ResponseBody
    public String batchDel(String ids, @RequestParam("dataType") String dataType)
    {
        switch (dataType)
        {
            case "rider":
                if(RiderDAOImpl.getRiderDAO().delete(ids))
                {
                    return "success";
                }
                break;
            case "user":
                if(UserDAOImpl.getDAO().delete(ids))
                {
                    return "success";
                }
                break;
            case "merchant":
                if(MerchantDAOImpl.getDao().delete(ids))
                {
                    return "success";
                }
                break;
            case "manager":
                if(ManagerDAOImpl.getManagerDAO().delete(ids))
                {
                    return "success";
                }
                break;
            case "orders":
                if(OrdersDAOImpl.getDao().delete(ids))
                {
                    return "success";
                }
                break;
            case "product":
                if(ProductDAOImpl.getDao().delete(ids))
                {
                    return "success";
                }
                break;
            case "productType":
                if(ProductTypeDAOImpl.getDao().delete(ids))
                {
                    return "success";
                }
                break;
        }
        return "fail";
    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
    }

}
