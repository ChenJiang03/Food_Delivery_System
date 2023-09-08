package com.example.uglytuan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

@Controller
@RequestMapping("/sliderCaptcha")
public class SliderCaptchaController
{

    @PostMapping("/isVerify")
    @ResponseBody
    public boolean isVerify(@RequestBody List<Integer> datas) {

        int sum = 0;
        for (Integer data : datas) {
            sum += data;
        }
        double avg = sum * 1.0 / datas.size();

        double sum2 = 0.0;
        for (Integer data : datas) {
            sum2 += Math.pow(data - avg, 2);
        }

        double stddev = sum2 / datas.size();
        return stddev != 0;

    }

}
