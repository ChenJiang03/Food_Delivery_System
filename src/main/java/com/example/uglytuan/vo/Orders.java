package com.example.uglytuan.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
    * 订单表
    */
public class Orders implements Serializable {
    /**
    * 次订单包含的菜品
    */
    private List<OrderDetail> goods;

    private Integer id;
/**订单号*/
    private String complicatedId;

    /**
    * 假删除
    */
    private Boolean enable;

    /**
    * 用户id
    */
    private User user;

    /**
    * 骑手id
    */
    private Rider rider;

    /**
    * 商家id
    */
    private Merchant merchant;

    /**
    * 用户下单状态
    */
    private Integer userFlag;

    /**
    * 商家接单状态
    */
    private Integer merchantFlag;

    /**
    * 骑手接单状态
    */
    private Integer riderFlag;

    /**
    * 下单时间
    */
    private Date regTime;
    /**
    * 评分
    */
    private Integer rating;

    /**
    * 评价详情
    */
    private String ratingDescription;

    /**
    * 订单状态
     * 0为未完成的订单
     * 1为已完成的订单
     * 2为已删除的订单
    */
    private Integer orderStatus;

    /**
    * 订单总价格
    */
    private BigDecimal totalPrice;

    private SysArea userProvince;

    private SysArea userCity;

    private SysArea userDistrict;

    private String userAddressDetail;

    private SysArea merchantProvince;

    private SysArea merchantCity;

    private SysArea merchantDistrict;

    private String merchantAddressDetail;

    public SysArea getUserProvince()
    {
        return userProvince;
    }

    public void setUserProvince(SysArea userProvince)
    {
        this.userProvince = userProvince;
    }

    public SysArea getUserCity()
    {
        return userCity;
    }

    public void setUserCity(SysArea userCity)
    {
        this.userCity = userCity;
    }

    public SysArea getUserDistrict()
    {
        return userDistrict;
    }

    public void setUserDistrict(SysArea userDistrict)
    {
        this.userDistrict = userDistrict;
    }

    public String getUserAddressDetail()
    {
        return userAddressDetail;
    }

    public void setUserAddressDetail(String userAddressDetail)
    {
        this.userAddressDetail = userAddressDetail;
    }

    public SysArea getMerchantProvince()
    {
        return merchantProvince;
    }

    public void setMerchantProvince(SysArea merchantProvince)
    {
        this.merchantProvince = merchantProvince;
    }

    public SysArea getMerchantCity()
    {
        return merchantCity;
    }

    public void setMerchantCity(SysArea merchantCity)
    {
        this.merchantCity = merchantCity;
    }

    public SysArea getMerchantDistrict()
    {
        return merchantDistrict;
    }

    public void setMerchantDistrict(SysArea merchantDistrict)
    {
        this.merchantDistrict = merchantDistrict;
    }

    public String getMerchantAddressDetail()
    {
        return merchantAddressDetail;
    }

    public void setMerchantAddressDetail(String merchantAddressDetail)
    {
        this.merchantAddressDetail = merchantAddressDetail;
    }

    private static final long serialVersionUID = 1L;

    public List<OrderDetail> getGoods()
    {
        return goods;
    }

    public void setGoods(List<OrderDetail> goods)
    {
        this.goods = goods;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {this.user= user;}

    public Rider getRider() {return rider;}

    public void setRider(Rider rider) {
       this.rider = rider;
    }

    public Merchant getMerchant() {
        return merchant;
    }

    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }

    public Integer getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(Integer userFlag) {
        this.userFlag = userFlag;
    }

    public Integer getMerchantFlag() {
        return merchantFlag;
    }

    public void setMerchantFlag(Integer merchantFlag) {
        this.merchantFlag = merchantFlag;
    }

    public Integer getRiderFlag() {
        return riderFlag;
    }

    public void setRiderFlag(Integer riderFlag) {
        this.riderFlag = riderFlag;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getRatingDescription() {
        return ratingDescription;
    }

    public void setRatingDescription(String ratingDescription) {
        this.ratingDescription = ratingDescription;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getComplicatedId() {
        return complicatedId;
    }

    public void setComplicatedId(String complicatedId) {
        this.complicatedId = complicatedId;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", enable=").append(enable);
        sb.append(", user=").append(user);
//        sb.append(", riderId=").append(riderId);
//        sb.append(", merchantId=").append(merchantId);
        sb.append(", userFlag=").append(userFlag);
        sb.append(", merchantFlag=").append(merchantFlag);
        sb.append(", riderFlag=").append(riderFlag);
        sb.append(", regTime=").append(regTime);
        sb.append(", rating=").append(rating);
        sb.append(", ratingDescription=").append(ratingDescription);
        sb.append(", orderStatus=").append(orderStatus);
        sb.append(", totalPrice=").append(totalPrice);
        sb.append("]");
        return sb.toString();
    }
}