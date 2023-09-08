package com.example.uglytuan.dao;

import com.example.uglytuan.vo.User;

import java.math.BigDecimal;

public interface UserDAO extends CommonDAO<User>
{
    User findByUsernameAndPass(String username,String password);
    boolean existUser(String username);
    boolean updatePassword(User object);
    public boolean recharge(Double balance,int id);
    boolean subBalance(int userId, BigDecimal needPrice);
}
