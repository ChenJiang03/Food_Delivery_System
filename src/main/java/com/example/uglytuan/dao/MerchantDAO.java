package com.example.uglytuan.dao;

import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Merchant;

import java.util.Date;
import java.util.List;

public interface MerchantDAO extends CommonDAO<Merchant>
{
    public Merchant findByUserAndPass(String username,String password);

    public boolean updateCenter(Merchant merchant);

    public boolean updatePass(Merchant merchant);

    public List<Merchant> search(int merchantTypeId, String keyword, String minTime, String maxTime);

    public List<Merchant> findAllCheck(PageUtils pageUtils);

    public boolean auditOk(int id);

    List<Merchant> findAll(PageUtils pageUtils);

    public boolean recharge(Double balance,int id);
}
