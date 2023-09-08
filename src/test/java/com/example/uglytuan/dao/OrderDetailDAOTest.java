package com.example.uglytuan.dao;

import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.vo.OrderDetail;
import com.example.uglytuan.vo.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;

import java.util.List;

public class OrderDetailDAOTest
{
    private OrderDetailDAO orderDetailDAO = OrderDetailDAOImpl.getDAO();
    @Test
    public void testFindByOrderId(){
        List<OrderDetail> orderDetails = orderDetailDAO.findByOrderId(1);
        orderDetails.forEach(System.out::println);
    }

    @Test
    public void testCopy(){
        User user1 = new User();
        user1.setName("aaa");
        user1.setPassword("111");


        User user2 = new User();
        user2.setName("bbb");
        user2.setId(1);

        BeanUtils.copyProperties(user1,user2);

        System.out.println(user2);
    }
}
