package com.example.uglytuan.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
    * 用户表单
    */
public class User implements Serializable {
    private Integer id;

    /**
    * 用户名
    */
    private String username;

    /**
    * 用户密码
    */
    private String password;

    /**
    * 用户照片
    */
    private String picture;

    /**
    * 用户名称
    */
    private String name;

    /**
    * 用户地址
    */
    private String address;

    /**
    * 用户电话号码
    */
    private String phone;

    /**
    * 用户生日
    */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    /**
    * 注册时间
    */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regTime;

    /**
    * 用户余额
    */
    private BigDecimal balance;

    /**
    * 假删除
    */
    private Boolean enable;

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

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", username=").append(username);
        sb.append(", password=").append(password);
        sb.append(", picture=").append(picture);
        sb.append(", name=").append(name);
        sb.append(", address=").append(address);
        sb.append(", phone=").append(phone);
        sb.append(", birthday=").append(birthday);
        sb.append(", regTime=").append(regTime);
        sb.append(", balance=").append(balance);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}