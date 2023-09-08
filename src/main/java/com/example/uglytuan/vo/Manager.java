package com.example.uglytuan.vo;

import java.io.Serializable;

/**
    * 后台管理员表
    */
public class Manager implements Serializable {
    private Integer id;

    private String username;

    private String password;

    /**
    * 是否为超级管理员
    */
    private Boolean superManager;

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

    public Boolean getSuperManager() {
        return superManager;
    }

    public void setSuperManager(Boolean superManager) {
        this.superManager = superManager;
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
        sb.append(", superManager=").append(superManager);
        sb.append(", enable=").append(enable);
        sb.append("]");
        return sb.toString();
    }
}