package com.example.uglytuan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage/address")
public class AddressController
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
//    @GetMapping("delete")
//    public String delete(int id){
//    }

    @GetMapping("update")
    public void updateInit(int id, Model model){
    }
}
