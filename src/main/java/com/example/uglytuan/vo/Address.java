package com.example.uglytuan.vo;

import java.io.Serializable;

/**
    * 地址表
    */
public class Address implements Serializable {
    private Integer id;

    /**
    * 用户id
    */

    /**
    * 用户地址
    */
    private String address;

    /**
    * 用户名字
    */
    private String name;

    /**
    * 用户电话
    */
    private String phone;

    /**
    * 是否为用户默认地址
    */
    private Boolean isDefault;

    /**
    * 假删除：0为删除，1为不删除
    */
    private Boolean enable;
    private SysArea province;
    private SysArea city;
    private SysArea district;
    private User user;
    private SysArea sysArea;

    public SysArea getSysArea()
    {
        return sysArea;
    }

    public void setSysArea(SysArea sysArea)
    {
        this.sysArea = sysArea;
    }

    public SysArea getProvince() {
        return province;
    }

    public void setProvince(SysArea province) {
        this.province = province;
    }

    public SysArea getCity() {
        return city;
    }

    public void setCity(SysArea city) {
        this.city = city;
    }

    public SysArea getDistrict() {
        return district;
    }

    public void setDistrict(SysArea district) {
        this.district = district;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setDefault(Boolean isDefault) {
        this.isDefault = isDefault;
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
        sb.append(", userId=").append(user.getId());
        sb.append(", address=").append(address);
        sb.append(", name=").append(name);
        sb.append(", phone=").append(phone);
        sb.append(", default=").append(isDefault);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}