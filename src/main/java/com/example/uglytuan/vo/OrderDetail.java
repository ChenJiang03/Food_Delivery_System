package com.example.uglytuan.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
    * 订单详情表
    */
public class OrderDetail implements Serializable {
    private Integer id;

    /**
    * 产品id
    */
    private Product product;

    /**
    * 订单id
    */
    private Orders ordersID;

    /**
    * 价格
    */
    private Double price;

    /**
    * 数量
    */
    private Integer amount;

    /**
    * 假删除
    */
    private Boolean enable;

    private Orders order;

    public Orders getOrder()
    {
        return order;
    }

    public void setOrder(Orders order)
    {
        this.order = order;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Orders getOrdersId() {
        return ordersID;
    }

    public void setOrdersId(Orders ordersId) {
        this.ordersID = ordersId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    @Override
    public String toString()
    {
        return "OrderDetail{" +
                "id=" + id +
                ", product=" + product +
                ", ordersID=" + ordersID +
                ", price=" + price +
                ", amount=" + amount +
                ", enable=" + enable +
                ", order=" + order +
                '}';
    }
}