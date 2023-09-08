package com.example.uglytuan.dao;

import com.example.uglytuan.vo.OrderDetail;

import java.util.List;

public interface OrderDetailDAO extends CommonDAO<OrderDetail>
{
    List<OrderDetail> findByOrderId(Integer orderId);
}
