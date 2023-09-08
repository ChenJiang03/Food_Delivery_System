package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.MerchantType;

import java.util.List;

public interface MerchantTypeDAO extends CommonDAO<MerchantType>
{
    public List<MerchantType> findAll(PageUtils pageUtils);
}
