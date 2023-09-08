package com.example.uglytuan.utils;

import org.springframework.ui.Model;

public class PageUtils
{
    private int pageNum=1;
    //
    private int pageSize=5;
    //
    private int dataCount;

    public static PageUtils init(String pageNum, Model model){
        int page=1;
        try{
            page=Integer.parseInt(pageNum);
        }
        catch (Exception e){

        }
        PageUtils pageUtils=new PageUtils();
        pageUtils.setPageNum(page);
        model.addAttribute("pageUtils",pageUtils);
        return pageUtils;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getDataCount() {
        return dataCount;
    }

    public void setDataCount(int dataCount) {
        this.dataCount = dataCount;
    }

    public int getPageCount(){
        return dataCount/pageSize+(dataCount%pageSize==0?0:1);
    }

    public int getFirstRow(){
        return (pageNum-1)*pageSize;
    }

    @Override
    public String toString()
    {
        return "PageUtils{" +
                "pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                ", dataCount=" + dataCount +
                '}';
    }
}
