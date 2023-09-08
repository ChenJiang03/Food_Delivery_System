package com.example.uglytuan.webcontroller;

import com.example.uglytuan.dao.impl.FavouriteDAOImpl;
import com.example.uglytuan.vo.Favourite;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/userCenter/favourite")
public class FavouriteController
{
    @RequestMapping("list")
    public String list(Model model){
        List<Favourite> favouriteList = FavouriteDAOImpl.getDAO().findAll();
        model.addAttribute("favouriteList",favouriteList);
        return "/userCenter/favourite/list";
    }

    @GetMapping("add")
    public String addInit(int merchantId, HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "redirect:/User/login";
        }
        Favourite favourite = new Favourite();
        Merchant merchant = new Merchant();
        merchant.setId(merchantId);
        favourite.setMerchant(merchant);
        favourite.setUser(user);
        FavouriteDAOImpl.getDAO().add(favourite);
        return "redirect:/userCenter/favourite/list";
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

    @GetMapping("delete")
    @ResponseBody
    public String delete(int id){
        if(FavouriteDAOImpl.getDAO().delete(id)){
            return "ok";
        }
        return "no";
    }

    @GetMapping("exist")
    @ResponseBody
    public String exist(int merchantId){
        if(FavouriteDAOImpl.getDAO().existSame(merchantId)){
            return "no";
        }
        return "ok";
    }
}
