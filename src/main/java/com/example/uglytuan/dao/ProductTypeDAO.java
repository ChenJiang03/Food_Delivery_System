package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.ProductType;

import java.util.List;

public interface ProductTypeDAO extends CommonDAO<ProductType>
{
    public List<ProductType> findAll(PageUtils pageUtils);
}
