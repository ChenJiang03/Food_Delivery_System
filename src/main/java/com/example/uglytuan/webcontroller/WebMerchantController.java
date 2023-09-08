package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.utils.CookieUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/Merchant")
public class WebMerchantController {

    @GetMapping("login")
    public void loginInit(){
        
    }

    @PostMapping("login")
    public String login(String username, String password, String rememberMe, Model model, HttpSession session, HttpServletResponse response){
        Merchant merchant=MerchantDAOImpl.getDao().findByUserAndPass(username,password);
        if(merchant==null){
            return "redirect:/Merchant/login";
        }

        if (rememberMe!=null){
            CookieUtils.addCookie("MerchantUsername",username,"/",60*60*7*30,response);
            CookieUtils.addCookie("MerchantPassword",password,"/",60*60*7*30,response);
        }
        else
        {
            CookieUtils.addCookie("MerchantUsername",username,"/",0,response);
            CookieUtils.addCookie("MerchantPassword",password,"/",0,response);

        }
        model.addAttribute("merchant",merchant);
        session.setAttribute("merchant",merchant);
        SysArea province = SysAreaDAOImpl.getDao().findById(merchant.getProvinceId());
        SysArea city = SysAreaDAOImpl.getDao().findById(merchant.getCityId());
        SysArea district = SysAreaDAOImpl.getDao().findById(merchant.getDistrictId());
        session.setAttribute("province", province);
        session.setAttribute("city", city);
        session.setAttribute("district", district);
        return "index";

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

    @GetMapping("register")
    public List<SysArea> registerInit(Model model){
        List<MerchantType> merchantTypeList=MerchantTypeDAOImpl.getMerchantType().findAll();
        model.addAttribute("merchantTypeList",merchantTypeList);
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }

    @GetMapping("getSysArea")
    @ResponseBody
    public List<SysArea> getSysArea(String id){
        List<SysArea> sysAreaList=SysAreaDAOImpl.getDao().findAll(id);
        return sysAreaList;
    }

    @PostMapping("register")
    public String register(Merchant object, MultipartFile[] file,HttpServletRequest request) throws IOException {

        String path=request.getServletContext().getRealPath("/img");

        String fileName=file[0].getOriginalFilename();
        int index=fileName.lastIndexOf(".");
        String fileExt=fileName.substring(index);
        String newFileName=UUID.randomUUID().toString();
        newFileName+=fileExt;
        file[0].transferTo(new File(path+"/"+newFileName));
        object.setCertificate("/img/"+newFileName);

        String fileName2=file[1].getOriginalFilename();
        int index2=fileName2.lastIndexOf(".");
        String fileExt2=fileName.substring(index);
        String newFileName2=UUID.randomUUID().toString();
        newFileName2+=fileExt2;
        file[1].transferTo(new File(path+"/"+newFileName));
        object.setPicture("/img/"+newFileName);

        MerchantDAOImpl.getDao().add(object);
        return "redirect:/Merchant/login";
    }
}
