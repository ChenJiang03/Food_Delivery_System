package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.OrdersDAO;
import com.example.uglytuan.dao.ProductDAO;
import com.example.uglytuan.dao.impl.*;
import com.example.uglytuan.utils.CommonUtils;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.vo.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Controller
@RequestMapping("/userCenter/orders")
public class webOrdersController {

    @RequestMapping("confirmOrders")
    public String confirmOrders(HttpSession session, Model model,String productId,int[] num,double total,int merchantId,String shoppingCar){
        User user  = (User)session.getAttribute("user");
        List<Address> addressList = AddressDAOImpl.getDao().findAll(user.getId());
        List<Product> productList=new ArrayList<>();
        List<ShoppingCar> shoppingCarList = new ArrayList<>();
        Merchant merchant = MerchantDAOImpl.getDao().findById(merchantId);
        if(productId.indexOf(",")>0){
            for(String i:productId.split(",")){
                Product product= ProductDAOImpl.getDao().findById(Integer.parseInt(i));
                productList.add(product);
            }
        }
        else{
            Product product= ProductDAOImpl.getDao().findById(Integer.parseInt(productId));
            productList.add(product);
        }

        if(shoppingCar.indexOf(",")>0){
            for(String i:shoppingCar.split(",")){
                ShoppingCar shoppingCar1 = ShoppingCarDAOImpl.getDAO().findById(Integer.parseInt(i));
                shoppingCarList.add(shoppingCar1);
            }
        }
        else{
            ShoppingCar shoppingCar1 = ShoppingCarDAOImpl.getDAO().findById(Integer.parseInt(shoppingCar));
            shoppingCarList.add(shoppingCar1);
        }
        model.addAttribute("addressList",addressList);
        model.addAttribute("productList",productList);
        model.addAttribute("num",num);
        model.addAttribute("total",total);
        model.addAttribute("merchant",merchant);
        model.addAttribute("shoppingCarList",shoppingCarList);
//        model.addAttribute("merchantList",merchantList);
        return "/userCenter/orders/confirmOrders";
    }

    @RequestMapping("submitOrders")
    public String submitOrders(int[] productId, int addressId, int[] num,BigDecimal total, HttpSession session,int merchantId,Model model,int[] shoppingCar){
        Address address = AddressDAOImpl.getDao().findById(addressId);
        SysArea province = new SysArea();
        SysArea city = new SysArea();
        SysArea district = new SysArea();
        SysArea merchantProvince = new SysArea();
        SysArea merchantCity = new SysArea();
        SysArea merchantDistrict = new SysArea();

        province.setId(address.getProvince().getId());
        city.setId(address.getCity().getId());
        district.setId(address.getDistrict().getId());

        User user = (User)session.getAttribute("user");
        Orders orders = new Orders();
        orders.setUser(user);
        Merchant merchant = MerchantDAOImpl.getDao().findById(merchantId);
        merchantProvince.setId(merchant.getProvinceId());
        merchantCity.setId(merchant.getCityId());
        merchantDistrict.setId(merchant.getDistrictId());

        merchant.setId(merchantId);
        orders.setMerchant(merchant);
        orders.setOrderStatus(0);
        orders.setTotalPrice(total);
        orders.setComplicatedId(CommonUtils.random(6));
        orders.setUserProvince(province);
        orders.setUserCity(city);
        orders.setUserDistrict(district);
        orders.setUserAddressDetail(address.getAddress());
        orders.setMerchantProvince(merchantProvince);
        orders.setMerchantCity(merchantCity);
        orders.setMerchantDistrict(merchantDistrict);
        orders.setMerchantAddressDetail(merchant.getAddress());
        OrdersDAOImpl.getDao().add(orders);

        Orders orders1 = OrdersDAOImpl.getDao().findNewAdd();
        for(int i=0;i<productId.length;i++){
            OrderDetail orderDetail = new OrderDetail();
            Product product = ProductDAOImpl.getDao().findById(productId[i]);
            product.setId(productId[i]);
            orderDetail.setProduct(product);
            orderDetail.setAmount(num[i]);
            orderDetail.setOrder(orders1);
            orderDetail.setPrice(product.getPrice());
            OrderDetailDAOImpl.getDAO().add(orderDetail);
        }
        String ordersNo = orders1.getComplicatedId();

        List<ShoppingCar> shoppingCarList = new ArrayList<>();
        for(int i = 0;i < shoppingCar.length;i++){
            ShoppingCar shoppingCar1 = ShoppingCarDAOImpl.getDAO().findById(shoppingCar[i]);
            shoppingCarList.add(shoppingCar1);
        }
        model.addAttribute("ordersNo",ordersNo);
        model.addAttribute("shoppingCarList",shoppingCarList);
        model.addAttribute("total",total);
        return "/userCenter/orders/pay";
    }

    @GetMapping("toPay")
    public String paySuccess(String ordersNo,Model model,int[] shoppingCarId,HttpSession session){
        OrdersDAOImpl.getDao().updateStatus(1,ordersNo);
        model.addAttribute("ordersNo",ordersNo);
        for(int i = 0;i < shoppingCarId.length;i++){
            ShoppingCar shoppingCar = ShoppingCarDAOImpl.getDAO().findById(shoppingCarId[i]);
            ShoppingCarDAOImpl.getDAO().delete(shoppingCar.getId());
        }
        return "/userCenter/orders/paySuccess";
    }


}
