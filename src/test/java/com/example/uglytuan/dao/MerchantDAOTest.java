package com.example.uglytuan.dao;

import com.example.uglytuan.dao.impl.MerchantDAOImpl;
import com.example.uglytuan.dao.impl.OrderDetailDAOImpl;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.OrderDetail;
import com.example.uglytuan.vo.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;

import java.util.List;

public class MerchantDAOTest
{
    private MerchantDAOImpl merchantDAO = MerchantDAOImpl.getDao();
    @Test
    public void testSearch3(){
        List<Merchant> merchants = merchantDAO.search3("1");
        merchants.forEach(System.out::println);
    }

}
