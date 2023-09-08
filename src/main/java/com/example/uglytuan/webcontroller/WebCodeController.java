package com.example.uglytuan.webcontroller;

import com.example.uglytuan.utils.ImageUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.PrintWriter;
import java.util.HashMap;

@Controller
@RequestMapping("/Code")
public class WebCodeController {

    @RequestMapping("getCode")
    public void getCode(HttpServletRequest request, HttpServletResponse response) throws Exception{
        HashMap<String,Object> map = ImageUtils.getImage();
        BufferedImage bi = (BufferedImage)map.get("bi");
        String code = (String)map.get("code");
        HttpSession session = request.getSession();
        session.setAttribute("code",code);
        ImageIO.write(bi,"jpg",response.getOutputStream());
    }

    @ResponseBody
    @RequestMapping("checkCode")
    public void checkCode(HttpServletResponse response,HttpServletRequest request) throws Exception{
        PrintWriter out=response.getWriter();
        String code=request.getParameter("code");
        HttpSession session=request.getSession();
        String code2=(String)session.getAttribute("code");
        if(code.equalsIgnoreCase(code2)){
            out.print("ok");
        }
        else{
            out.print("no");
        }
        out.close();

    }
}
