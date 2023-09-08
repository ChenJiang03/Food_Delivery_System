package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.dao.impl.ShoppingCarDAOImpl;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.Product;
import com.example.uglytuan.vo.ShoppingCar;
import com.example.uglytuan.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/userCenter/shoppingCar")
public class ShoppingCarController
{
    @GetMapping("list")
    public String list(Model model,HttpSession session,int merchantId){
        User user = (User)session.getAttribute("user");
        if(user == null){
            return "redirect:/User/login";
        }
        List<ShoppingCar> shoppingCarList = ShoppingCarDAOImpl.getDAO().findAll(user.getId(),merchantId);
        Merchant merchant = MerchantDAOImpl.getDao().findById(merchantId);
        model.addAttribute("shoppingCarList",shoppingCarList);
        model.addAttribute("merchant",merchant);
        return "/userCenter/shoppingCar/list";
    }

    @GetMapping("add")
    @ResponseBody
    public String add(int number, int productId, int merchantId, HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "notLogin";
        }
        ShoppingCar shoppingCar = ShoppingCarDAOImpl.getDAO().exist(productId, user.getId());
        if(shoppingCar!=null){
            ShoppingCarDAOImpl.getDAO().addNum(number,shoppingCar.getId());
            return "ok";
        }
        ShoppingCar sc=new ShoppingCar();
        sc.setUserId(user.getId());
        sc.setProductId(productId);
        sc.setMerchantId(merchantId);
        sc.setAmount(number);
        ShoppingCarDAOImpl.getDAO().add(sc);
        return "ok";

    }

//    @PostMapping("add")
//    public String add(Product product){
//    }
//
//    @GetMapping("delete")
//    public String delete(int id){
//    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
    }

    @GetMapping("searchItems")
    @ResponseBody
    public List<ShoppingCar> searchItems(int merchantId, HttpSession session){
        User user = (User)session.getAttribute("user");
        List<ShoppingCar> shoppingList = ShoppingCarDAOImpl.getDAO().findAll(user.getId(),merchantId);
        return shoppingList;
    }

    @GetMapping("delete")
    @ResponseBody
    public String delete(int shoppingCarId){
        if(ShoppingCarDAOImpl.getDAO().delete(shoppingCarId)){
            return "ok";
        }
        return "no";
    }
}
