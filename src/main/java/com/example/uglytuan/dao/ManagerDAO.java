package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Manager;

import java.util.List;

public interface ManagerDAO extends CommonDAO<Manager>
{
    List<Manager> search(String keywords,PageUtils pageUtils);
    List<Manager> findAll(PageUtils pageUtils);
    boolean existManager(String username);
}
