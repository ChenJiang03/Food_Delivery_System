package com.example.uglytuan.controller;

import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.dao.impl.OrdersDAOImpl;
import com.example.uglytuan.dao.impl.RiderDAOImpl;
import com.example.uglytuan.dao.impl.SysAreaDAOImpl;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/manage/rider")
public class RiderController
{
    @GetMapping("list")
    public List<SysArea> list(Model model, String pageNum){
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        List<Rider> riderList = RiderDAOImpl.getRiderDAO().findAll(pageUtils);
        model.addAttribute("riderList", riderList);
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }
    @PostMapping("list")
    public void listByCondition(Model model, Rider rider, String keywords, Boolean available, String pageNum)
    {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList", sysAreaList);
        Boolean provinceFlag = !rider.getProvince().getId().equals("");
        Boolean cityFlag = !rider.getCity().getId().equals("");
        Boolean districtFlag = !rider.getDistrict().getId().equals("");
        Boolean keywordsFlag = !keywords.equals("");
        String sql = "where enable=1 ";
        if (!provinceFlag && !cityFlag && !districtFlag && !keywordsFlag && available==null)
        {
            List<Rider> riderList = RiderDAOImpl.getRiderDAO().findByCondition(sql,pageUtils);
            model.addAttribute("riderList", riderList);
            return;
        }
        if (!keywordsFlag) //���keywordsFlag��false�Ļ���keywordsΪ�գ�
        {
            if (districtFlag) //���districtFlag��true�Ļ���district��Ϊ�գ�
            {
                sql += "and district_id="+rider.getDistrict().getId();
            }
            else if (cityFlag) //���cityFlag��true�Ļ���city��Ϊ�գ�
            {
                sql += "and city_id="+rider.getCity().getId();
            }
            else if(provinceFlag)
            {
                sql += "and province_id="+rider.getProvince().getId();
            }
        }
        else
        {
            sql += "and (username like '%" + keywords + "%' or phone='" + keywords + "' or name like '%" + keywords
            + "%' or identification='" + keywords + "')";
            if (districtFlag) //���districtFlag��true�Ļ���district��Ϊ�գ�
            {
                sql += " and district_id="+rider.getDistrict().getId();
            }
            else if (cityFlag) //���cityFlag��true�Ļ���city��Ϊ�գ�
            {
                sql += " and city_id="+rider.getCity().getId();
            }
            else if(provinceFlag)
            {
                sql += " and province_id="+rider.getProvince().getId();
            }
        }
        if (available != null)
        {
            if (available)// �����ѯ��ʱ��ѡ����ǿɹ���������
            {
                sql += " and available=1";
            }
            else
            {
                sql += " and available=0";
            }
        }
        List<Rider> riderList = RiderDAOImpl.getRiderDAO().findByCondition(sql,pageUtils);
        model.addAttribute("riderList", riderList);
    }

    @GetMapping("add")
    public List<SysArea> addInit(Model model){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }

    @PostMapping("add")
    public String add(Rider rider){
        RiderDAOImpl.getRiderDAO().add(rider);
        return "redirect:/manage/rider/list";
    }

    @GetMapping("delete")
    public String delete(int id){
        RiderDAOImpl.getRiderDAO().delete(id);
        return "redirect:/manage/rider/list";
    }

    @GetMapping("update")
    public void updateInit(Integer id, Model model){
        System.out.println(id);
        Rider rider = RiderDAOImpl.getRiderDAO().findById(id);
        model.addAttribute("rider", rider);
        List<SysArea> sysAreaList=SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList", sysAreaList);
    }

    @PostMapping("update")
    public String update(Rider rider)
    {
        System.out.println(rider.getScore());
        RiderDAOImpl.getRiderDAO().update(rider);
        return "redirect:/manage/rider/list";
    }

    @GetMapping("existRider")
    @ResponseBody
    public String existRider(String username, HttpServletResponse response) throws IOException
    {
        if (RiderDAOImpl.getRiderDAO().existRider(username))
        {
            return "no";
        }
        else
        {
            return "ok";
        }
    }
    @PostMapping("uploadPic")
    @ResponseBody
    public String uploadPic(MultipartFile file, HttpServletRequest request) throws IOException {
        String fileName=file.getOriginalFilename();
        if(fileName.trim().length()!=0){
            int index=fileName.lastIndexOf(".");
            String fileExt=fileName.substring(index);
            String newFileName= UUID.randomUUID().toString();
            newFileName+=fileExt;
            String path=request.getServletContext().getRealPath("/img");
            file.transferTo(new File(path+"/"+newFileName));
            return "/img/"+newFileName;
        }
        return "fail";
    }

    @GetMapping("getSysArea")
    @ResponseBody
    public List<SysArea> getSysArea(String id){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll(id);
        return sysAreaList;
    }

    @GetMapping("showList")
    public String list(Model model, Rider rider, String keywords, Boolean available, String pageNum)
    {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        model.addAttribute("sysAreaList", sysAreaList);
        Boolean provinceFlag = !rider.getProvince().getId().equals("");
        Boolean cityFlag = !rider.getCity().getId().equals("");
        Boolean districtFlag = !rider.getDistrict().getId().equals("");
        Boolean keywordsFlag = !keywords.equals("");
        String sql = "where enable=1 ";
        if (!provinceFlag && !cityFlag && !districtFlag && !keywordsFlag && available==null)
        {
            List<Rider> riderList = RiderDAOImpl.getRiderDAO().findByCondition(sql,pageUtils);
            model.addAttribute("riderList", riderList);
            return "/manage/rider/list";
        }
        if (!keywordsFlag) //���keywordsFlag��false�Ļ���keywordsΪ�գ�
        {
            if (districtFlag) //���districtFlag��true�Ļ���district��Ϊ�գ�
            {
                sql += "and district_id="+rider.getDistrict().getId();
            }
            else if (cityFlag) //���cityFlag��true�Ļ���city��Ϊ�գ�
            {
                sql += "and city_id="+rider.getCity().getId();
            }
            else if(provinceFlag)
            {
                sql += "and province_id="+rider.getProvince().getId();
            }
        }
        else
        {
            sql += "and (username like '%" + keywords + "%' or phone='" + keywords + "' or name like '%" + keywords
                    + "%' or identification='" + keywords + "')";
            if (districtFlag) //���districtFlag��true�Ļ���district��Ϊ�գ�
            {
                sql += " and district_id="+rider.getDistrict().getId();
            }
            else if (cityFlag) //���cityFlag��true�Ļ���city��Ϊ�գ�
            {
                sql += " and city_id="+rider.getCity().getId();
            }
            else if(provinceFlag)
            {
                sql += " and province_id="+rider.getProvince().getId();
            }
        }
        if (available != null)
        {
            if (available)// �����ѯ��ʱ��ѡ����ǿɹ���������
            {
                sql += " and available=1";
            }
            else
            {
                sql += " and available=0";
            }
        }
        List<Rider> riderList = RiderDAOImpl.getRiderDAO().findByCondition(sql,pageUtils);
        model.addAttribute("riderList",riderList);
        model.addAttribute("keywords",keywords);
        return "/manage/rider/list";
    }


    @GetMapping("orders")
    public List<Orders> getOrders(@RequestParam("id") Integer id, Model model, String pageNum)
    {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        System.out.println(id);
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByRiderId(id, pageUtils);
        model.addAttribute("rider_id", id);
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
