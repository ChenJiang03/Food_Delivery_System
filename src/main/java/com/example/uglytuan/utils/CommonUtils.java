package com.example.uglytuan.utils;



import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.Random;

public class CommonUtils {
        public static String random(int num){
            Random rand=new Random();
            String str="";
            for(int i=0;i<num;i++){
                str+=rand.nextInt(10);
            }
            //当前时间转成毫秒
            long time=System.currentTimeMillis();
            return time+str;
        }

        public static void main(String[] args) {
            String num=CommonUtils.random(5);
            System.out.println(num);
        }


}
