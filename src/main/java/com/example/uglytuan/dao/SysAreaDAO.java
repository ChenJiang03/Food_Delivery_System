package com.example.uglytuan.dao;

import com.example.uglytuan.vo.SysArea;

import java.util.List;

public interface SysAreaDAO extends CommonDAO<SysArea>
{
    public List<SysArea> findAll(String id);
    public SysArea findById(String id);
}
