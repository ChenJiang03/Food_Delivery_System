package com.example.uglytuan.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.Random;

public class ImageUtils {
    private static int width = 150;
    private static int height = 50;
    private static int codeCount = 5;
    private static Random random = new Random();

    private static String generateCode(){
        String code = "";
        char[] codeArr = new char[62];
        int index=0;
        for(int i='0';i<='9';i++) {
            codeArr[index]=(char)i;
            index++;
        }
        for(int i='A';i<='Z';i++) {
            codeArr[index]=(char)i;
            index++;
        }
        for(int i='a';i<='z';i++) {
            codeArr[index]=(char)i;
            index++;
        }
        for(int i=0;i<codeCount;i++) {
            char c=codeArr[random.nextInt(codeArr.length)];
            code+=c;
        }
        return code;
    }

    public static HashMap<String,Object> getImage() {
        //键值对集合 k v
        HashMap<String,Object> map=new HashMap<>();
        BufferedImage bi=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
        Graphics gr=bi.getGraphics();
        gr.fillRect(0,0, width, height);
        String code=generateCode();
        int x=0;
        int y=height-10;
        for(int i=0;i<code.length();i++) {
            int r=random.nextInt(255);
            int g=random.nextInt(255);
            int b=random.nextInt(255);
            gr.setFont(new Font("宋体",Font.BOLD,20+random.nextInt(30)));
            gr.setColor(new Color(r,g,b));
            gr.drawString(String.valueOf(code.charAt(i)),x, y);
            x+=width/codeCount;
        }
        for(int i=0;i<10;i++) {
            int x1=random.nextInt(width);
            int y1=random.nextInt(height);
            int x2=random.nextInt(width);
            int y2=random.nextInt(height);

            int r=random.nextInt(255);
            int g=random.nextInt(255);
            int b=random.nextInt(255);
            gr.setColor(new Color(r,g,b));
            gr.drawLine(x1, y1, x2, y2);
        }
        map.put("bi",bi);
        map.put("code",code);
        return map;
    }
}
