package com.example.uglytuan.vo;

import java.io.Serializable;

/**
    * 产品类型表
    */
public class ProductType implements Serializable {
    private Integer id;

    /**
    * 产品类型名称
    */
    private String title;

    /**
    * 产品类型介绍
    */
    private String description;

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
        sb.append(", title=").append(title);
        sb.append(", description=").append(description);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}