package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Product;

import java.util.List;

public interface ProductDAO extends CommonDAO<Product>
{
    public List<Product> findByMerchantId(Integer id,PageUtils pageUtils);
    public List<Product> findByMerchantId(Integer id);
    public boolean updateById(Product product);
}
