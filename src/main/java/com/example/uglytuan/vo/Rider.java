package com.example.uglytuan.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
    * 骑手表
    */
public class Rider implements Serializable {
    private Integer current_orders;
    private SysArea province;
    private SysArea city;
    private SysArea district;
    private Integer id;

    /**
    * 骑手用户名
    */
    private String username;

    /**
    * 骑手密码
    */
    private String password;

    /**
    * 骑手电话号码
    */
    private String phone;

    /**
    * 骑手名字
    */
    private String name;

    /**
    * 假删除
    */
    private Boolean enable;

    /**
    * 骑手余额
    */
    private Double balance;

    /**
    * 骑手身份证号
    */
    private String identification;

    /**
    * 骑手评分
    */
    private Double score;

    /**
    * 骑手照片
    */
    private String picture;

    /**
    * 骑手是否能接单，1为能接单，0为不能接单
    */
    private Boolean available;

    public Integer getCurrent_orders()
    {
        return current_orders;
    }

    public void setCurrent_orders(Integer current_orders)
    {
        this.current_orders = current_orders;
    }

    public SysArea getProvince()
    {
        return province;
    }

    public void setProvince(SysArea province)
    {
        this.province = province;
    }

    public SysArea getCity()
    {
        return city;
    }

    public void setCity(SysArea city)
    {
        this.city = city;
    }

    public SysArea getDistrict()
    {
        return district;
    }

    public void setDistrict(SysArea district)
    {
        this.district = district;
    }

    /**
    * 注册时间
    */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regTime;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public String getIdentification() {
        return identification;
    }

    public void setIdentification(String identification) {
        this.identification = identification;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    @Override
    public String toString()
    {
        return "Rider{" +
                "province=" + province +
                ", city=" + city +
                ", district=" + district +
                ", id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", name='" + name + '\'' +
                ", enable=" + enable +
                ", balance=" + balance +
                ", identification='" + identification + '\'' +
                ", score=" + score +
                ", picture='" + picture + '\'' +
                ", available=" + available +
                ", regTime=" + regTime +
                '}';
    }
}