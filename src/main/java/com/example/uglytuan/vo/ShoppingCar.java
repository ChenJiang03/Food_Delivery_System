package com.example.uglytuan.vo;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

/**
    * 购物车
    */
public class ShoppingCar implements Serializable {
    private Integer id;

    /**
    * 用户id
    */
    private Integer userId;

    /**
    * 商家id
    */
    private Integer merchantId;

    /**
    * 产品id
    */
    private Integer productId;

    /*
     * Map里面放了一个Map，关联User和
     */
    private Map<User, Map<Merchant, Product>> products;

    /**
    * 产品数量
    */
    private Integer amount;

    /**
    * 产品总价格
    */

    /**
    * 添加时间
    */
    private Date addTime;

    /**
    * 假删除
    */
    private Integer enable;

    private Product product;

    private Merchant merchant;

    public Merchant getMerchant() {
        return merchant;
    }

    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }



    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", merchantId=").append(merchantId);
        sb.append(", productId=").append(productId);
        sb.append(", amount=").append(amount);
        sb.append(", addTime=").append(addTime);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}