package com.example.uglytuan.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
    * 商品表
    */
public class Product implements Serializable {
    private Integer id;

    /**
    * 产品名称
    */
    private String title;

    /**
    * 产品介绍
    */
    private String description;

    /**
    * 产品图片
    */
    private String picture;

    /**
    * 商家id
    */
    private Integer merchantId;

    /**
    * 假删除
    */
    private Boolean enable;

    /**
    * 是否有库存，0为没库存，1为有库存
    */
    private Boolean stock;

    /**
    * 产品类型id
    */
    private Integer productTypeId;

    /**
    * 产品价格
    */
    private Double price;

    private Merchant merchant;

    public Merchant getMerchant() {
        return merchant;
    }

    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Boolean getStock() {
        return stock;
    }

    public void setStock(Boolean stock) {
        this.stock = stock;
    }

    public Integer getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(Integer productTypeId) {
        this.productTypeId = productTypeId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", title=").append(title);
        sb.append(", description=").append(description);
        sb.append(", picture=").append(picture);
        sb.append(", merchantId=").append(merchantId);
        sb.append(", enable=").append(enable);
        sb.append(", stock=").append(stock);
        sb.append(", productTypeId=").append(productTypeId);
        sb.append(", price=").append(price);
        sb.append("]");
        return sb.toString();
    }
}