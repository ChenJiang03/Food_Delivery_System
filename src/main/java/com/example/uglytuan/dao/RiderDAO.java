package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Rider;

import java.util.List;

public interface RiderDAO extends CommonDAO<Rider>
{
    boolean existRider(String username);
    Rider findByUsernameAndPass(String username, String password);
    public List<Rider> findAll(PageUtils pageUtils);
    public boolean updatePassword(Rider object, String newPassword);
    public List<Rider> findByCondition(String condition,PageUtils pageUtils);
}
