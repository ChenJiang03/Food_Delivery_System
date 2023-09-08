package com.example.uglytuan.vo;

import java.io.Serializable;

/**
    * 商家类型
    */
public class MerchantType implements Serializable {
    private Integer id;

    /**
    * 商家类型
    */
    private String type;

    /**
    * 类型介绍
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
        sb.append(", type=").append(type);
        sb.append(", description=").append(description);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}