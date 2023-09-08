package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.ProductDAO;
import com.example.uglytuan.dao.RiderDAO;
import com.example.uglytuan.dao.SysAreaDAO;
import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.utils.PageUtils;
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
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/riderCenter")
public class WebRiderController
{

    private RiderDAO riderDAO = RiderDAOImpl.getRiderDAO();

    @GetMapping("register")
    public List<SysArea> register(){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }

    @PostMapping("register")
    public String register(Rider rider)
    {
        this.riderDAO.add(rider);
        //重定向 不会再加上前缀和后缀了
        return "redirect:/riderCenter/login?msg=success";
    }
    
    @GetMapping("login")
    public void login(){}


    @PostMapping("login")
    public String login(String username, String password, HttpSession session)
    {
        Rider rider = this.riderDAO.findByUsernameAndPass(username, password);
        if (rider==null)
        {
            return "redirect:/riderCenter/login?msg=error";
        }
        session.setAttribute("rider",rider);

        return "redirect:/riderCenter/index";
    }
    @GetMapping("list")
    public void list()
    {

    }
    @GetMapping("existRider")
    @ResponseBody
    public String existRider(String username) throws IOException
    {
        if (this.riderDAO.existRider(username))
        {
           return "no";
        }
        else
        {
            return "ok";
        }
    }
    @GetMapping("checkPassword")
    @ResponseBody
    public String checkPassword(String oldPassword, HttpSession session) throws IOException
    {
        Rider rider = (Rider)session.getAttribute("rider");
        if (oldPassword.equals(rider.getPassword()))
        {
           return "ok";
        }
        else
        {
            return "no";
        }
    }

    @RequestMapping ("index")
    public void index()
    {
    }
    @GetMapping("update")
    public void updateInit()
    {
    }
    @PostMapping("update")
    public String update(Rider rider,HttpSession session)
    {
        Rider updateRider = (Rider)session.getAttribute("rider");
        updateRider.setUsername(rider.getUsername());
        updateRider.setPicture(rider.getPicture());
        updateRider.setName(rider.getName());
        updateRider.setAvailable(rider.getAvailable());
        updateRider.setPhone(rider.getPhone());
        RiderDAOImpl.getRiderDAO().update(updateRider);
        return "redirect:/riderCenter/index";
    }
    @GetMapping("updatePass")
    public void updatePassInit()
    {
    }
    @PostMapping("updatePass")
    public String updatePass(HttpSession session, String newPassword)
    {
        Rider rider = (Rider)session.getAttribute("rider");
        RiderDAOImpl.getRiderDAO().updatePassword(rider, newPassword);
        session.removeAttribute("rider");
        return "redirect:/riderCenter/login";
    }
    @GetMapping("address/update")
    public List<SysArea> addressAddInit()
    {
        List<SysArea> sysAreaList=SysAreaDAOImpl.getDao().findAll("0");
        return sysAreaList;
    }
    @PostMapping("address/update")
    public String addressUpdate(Rider rider, HttpSession session)
    {
        Rider oldRider = (Rider) session.getAttribute("rider");
        SysArea province = SysAreaDAOImpl.getDao().findById(rider.getProvince().getId());
        SysArea city = SysAreaDAOImpl.getDao().findById(rider.getCity().getId());
        SysArea district = SysAreaDAOImpl.getDao().findById(rider.getDistrict().getId());
        oldRider.setProvince(province);
        oldRider.setCity(city);
        oldRider.setDistrict(district);
        RiderDAOImpl.getRiderDAO().update(oldRider);
        return "redirect:/riderCenter/index";
    }

    @PostMapping("uploadPic")
    @ResponseBody
    public String uploadPic( HttpServletRequest request, MultipartFile file) throws IOException {
        String fileName = file.getOriginalFilename();
        if(fileName.trim().length()!=0){
            int index = fileName.lastIndexOf(".");
            String fileExt = fileName.substring(index);
            String newFileName = UUID.randomUUID().toString();
            newFileName =  newFileName+fileExt;
//获得当前项目的运行路径
            String path = request.getServletContext().getRealPath("/img");
// 将图片存入文件夹
            file.transferTo(new File(path+"/"+newFileName));
            return "/img/"+newFileName;

        }

        return "fail";

    }

    @GetMapping("address/getSysArea")
    @ResponseBody
    public List<SysArea> getSysArea(String id){
        List<SysArea> sysAreaList= SysAreaDAOImpl.getDao().findAll(id);
        return sysAreaList;
    }
    @RequestMapping("exit")
    public String exit(HttpSession session)
    {
        session.removeAttribute("rider");
        return "redirect:/riderCenter/login";
    }
    @GetMapping("orders/list")
    public List<Orders> listOrders(HttpSession session, Model model, String pageNum)
    {
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        Rider rider = (Rider) session.getAttribute("rider");
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByRiderId(rider.getId(), pageUtils);
        return ordersList;
    }

    /*
    加了排序的方法
     */
    @GetMapping("orders/showList")
    public String showListOrdersByCondition(String pageNum, HttpSession session, Model model, String keywords)
    {
        Rider rider = (Rider) session.getAttribute("rider");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils,"rider", rider.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "riderCenter/orders/list";
    }

    @PostMapping("orders/list")
    public String listOrdersByCondition(String pageNum, HttpSession session, Model model, String keywords)
    {
        Rider rider = (Rider) session.getAttribute("rider");
        PageUtils pageUtils = PageUtils.init(pageNum, model);
        pageUtils.setPageSize(5);
        List<Orders> ordersList = OrdersDAOImpl.getDao().searchOrdersByType(keywords, pageUtils,"rider", rider.getId());
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("keywords", keywords);
        return "riderCenter/orders/list";
    }

    @RequestMapping("orders/accept")
    public String acceptOrder(@RequestParam("id") Integer id)
    {
        OrdersDAOImpl.getDao().updateRiderFlag(id);
        return "redirect:/riderCenter/orders/newOrders";
    }

    @GetMapping("orders/ordersInfo")
    public Orders ordersInfo(@RequestParam("id") Integer id, Model model)
    {
        Orders orders = OrdersDAOImpl.getDao().findById(id);
        List<OrderDetail> orderDetails = OrderDetailDAOImpl.getDAO().findByOrderId(id);
        model.addAttribute("orderDetails", orderDetails);
        return orders;
    }

    @RequestMapping("orders/orderStatus")
    public String orderStatus(@RequestParam("order_status") Integer order_status, HttpSession session, String pageNum, Model model)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        Rider rider = (Rider) session.getAttribute("rider");
        List<Orders>  ordersList= OrdersDAOImpl.getDao().findByOrderStatus(order_status, rider.getId(),"rider", pageUtils);
        model.addAttribute("ordersList", ordersList);
        model.addAttribute("order_status", order_status);
        return "/riderCenter/orders/orderStatus";
    }

    @GetMapping("orders/newOrders")
    public List<Orders> newOrders(HttpSession session, Model model, String pageNum)
    {
        PageUtils pageUtils=PageUtils.init(pageNum,model);
        pageUtils.setPageSize(5);
        Rider rider = (Rider) session.getAttribute("rider");
        List<Orders> ordersList = OrdersDAOImpl.getDao().findByRiderIdAndUserFlagAndMerchantFlag(rider.getId(), pageUtils);
        return ordersList;
    }

    @RequestMapping("orders/cancel")
    public String cancelOrder(@RequestParam("id") Integer id)
    {
        OrdersDAOImpl.getDao().cancelOrder(id);
        return "redirect:/riderCenter/orders/newOrders";
    }

    @RequestMapping("orders/finish")
    public String finishOrder(Integer id, HttpSession session)
    {
        Orders orders = OrdersDAOImpl.getDao().findById(id);
        OrdersDAOImpl.getDao().finishOrder(orders, orders.getRider().getCurrent_orders(), orders.getRider().getId());
        User user = (User) session.getAttribute("user");
        if (user != null)
        {
            User newUser = UserDAOImpl.getDAO().findById(user.getId());
            user.setBalance(newUser.getBalance());
        }
        Merchant merchant = (Merchant) session.getAttribute("merchant");
        if (merchant != null)
        {
            Merchant newMerchant = MerchantDAOImpl.getDao().findById(merchant.getId());
            merchant.setBalance(newMerchant.getBalance());
        }
        Rider rider = (Rider) session.getAttribute("rider");
        if (rider!=null)
        {
            Rider newRider = RiderDAOImpl.getRiderDAO().findById(rider.getId());
            rider.setBalance(newRider.getBalance());
        }
        return "redirect:/riderCenter/orders/newOrders";
    }

    @RequestMapping("orders/search")
    public void searchOrders()
    {
    }
}
