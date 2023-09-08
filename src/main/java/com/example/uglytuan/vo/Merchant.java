package com.example.uglytuan.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
    * 商家表
    */
public class Merchant implements Serializable {
    private Integer id;

    private String username;

    private String password;

    /**
     * 商家地址-省
     */
    private String provinceId;

    /**
     * 商家地址-市
     */
    private String cityId;

    /**
     * 商家地址-区
     */
    private String districtId;

    /**
    * 商家地址
    */
    private String address;

    /**
    * 商家电话
    */
    private String phone;

    /**
    * 商家名称
    */
    private String name;

    /**
    * 注册时间
    */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regTime;

    /**
    * 假删除
    */
    private Integer enable;

    /**
    * 老板名字
    */
    private String bossName;

    /**
    * 老板电话
    */
    private String bossPhone;

    /**
    * 老板身份证号
    */
    private String bossId;

    /**
    * 营业执照
    */
    private String certificate;

    /**
    * 商家照片
    */
    private String picture;

    /**
    * 商家类型id
    */
    private Integer merchantTypeId;

    /**
    * 商家简介
    */
    private String description;

    /**
    * 商家余额
    */
    private Double balance;

    /**
    * 是否检查通过：0为待检查，1为检查通过，2为检查不通过
    */
    private Boolean check;

    /**
    * 商家评分
    */
    private Double score;

    private MerchantType merchantType;

    private ProductType productType;

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public MerchantType getMerchantType() {
        return merchantType;
    }

    public void setMerchantType(MerchantType merchantType) {
        this.merchantType = merchantType;
    }

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public String getBossName() {
        return bossName;
    }

    public void setBossName(String bossName) {
        this.bossName = bossName;
    }

    public String getBossPhone() {
        return bossPhone;
    }

    public void setBossPhone(String bossPhone) {
        this.bossPhone = bossPhone;
    }

    public String getBossId() {
        return bossId;
    }

    public void setBossId(String bossId) {
        this.bossId = bossId;
    }

    public String getCertificate() {
        return certificate;
    }

    public void setCertificate(String certificate) {
        this.certificate = certificate;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Integer getMerchantTypeId() {
        return merchantTypeId;
    }

    public void setMerchantTypeId(Integer merchantTypeId) {
        this.merchantTypeId = merchantTypeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId;
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId;
    }

    public String getDistrictId() {
        return districtId;
    }

    public void setDistrictId(String districtId) {
        this.districtId = districtId;
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
        sb.append(", address=").append(address);
        sb.append(", phone=").append(phone);
        sb.append(", name=").append(name);
        sb.append(", regTime=").append(regTime);
        sb.append(", enable=").append(enable);
        sb.append(", bossName=").append(bossName);
        sb.append(", bossPhone=").append(bossPhone);
        sb.append(", bossId=").append(bossId);
        sb.append(", certificate=").append(certificate);
        sb.append(", picture=").append(picture);
        sb.append(", merchantTypeId=").append(merchantTypeId);
        sb.append(", description=").append(description);
        sb.append(", balance=").append(balance);
        sb.append(", check=").append(check);
        sb.append(", score=").append(score);
        sb.append("]");
        return sb.toString();
    }
}