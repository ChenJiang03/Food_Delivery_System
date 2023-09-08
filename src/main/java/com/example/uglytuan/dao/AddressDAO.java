package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Address;

import java.util.List;

public interface AddressDAO extends CommonDAO<Address>
{
    void updateDefault(Integer id);
    List<Address> findAll(int userId, PageUtils pageUtils);
}
