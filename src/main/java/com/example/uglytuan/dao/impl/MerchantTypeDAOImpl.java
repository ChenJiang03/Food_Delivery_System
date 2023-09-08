package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.MerchantTypeDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.MerchantType;
import com.example.uglytuan.vo.ProductType;
import com.example.uglytuan.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MerchantTypeDAOImpl implements MerchantTypeDAO
{

    private static MerchantTypeDAOImpl merchantTypeDAO = new MerchantTypeDAOImpl();
    private MerchantTypeDAOImpl(){}
    public static MerchantTypeDAOImpl getMerchantType(){
        return merchantTypeDAO;

    }


    @Override
    public boolean add(MerchantType merchantType)
    {
        String sql="insert into merchant_type(type,description) value(?,?)";
        Object[] params={
                merchantType.getType(),
                merchantType.getDescription()
        };
        return DBUtils.executeUpdate(sql,params);

    }

    @Override
    public boolean delete(MerchantType object)
    {
        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update merchant_type set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update merchant_type set enable=0 where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(MerchantType merchant)
    {
        String sql="update merchant_type set type=?,description=? where id=?";
        Object[] params={
                merchant.getType(),
                merchant.getDescription(),
                merchant.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public MerchantType findById(Integer id)
    {
        String sql = "select * from merchant_type where enable=1 and id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        MerchantType merchantType=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
              merchantType = new MerchantType();
              merchantType.setType(rs.getString("type"));
              merchantType.setId(rs.getInt("id"));
              merchantType.setDescription(rs.getString("description"));
              merchantType.setEnable(rs.getBoolean("enable"));
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return merchantType;
    }

    @Override
    public List<MerchantType> findAll()
    {
        List<MerchantType> merchantTypeList=new ArrayList<>();

        String sql ="select * from merchant_type where enable=1";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        MerchantType merchantType=null;

        try {
            ps=conn.prepareStatement(sql);
            rs=ps.executeQuery();
            while (rs.next()){
                merchantType=new MerchantType();
                merchantType.setId(rs.getInt("id"));
                merchantType.setType(rs.getString("type"));
                merchantType.setDescription(rs.getString("description"));
                merchantType.setEnable(rs.getBoolean("enable"));
                merchantTypeList.add(merchantType);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return merchantTypeList;

    }

    @Override
    public List<MerchantType> findAll(PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount());
        List<MerchantType> merchantTypeList=new ArrayList<>();

        String sql ="select * from merchant_type where enable=1";
        sql +=" limit ?,?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        MerchantType merchantType=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs=ps.executeQuery();
            while (rs.next()){
                merchantType=new MerchantType();
                merchantType.setId(rs.getInt("id"));
                merchantType.setType(rs.getString("type"));
                merchantType.setDescription(rs.getString("description"));
                merchantType.setEnable(rs.getBoolean("enable"));
                merchantTypeList.add(merchantType);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return merchantTypeList;

    }

    public int getCount(){
        String sql = "select count(*) count from merchant_type where enable =1 ";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return 0;
    }

    public List<MerchantType> findPage(PageUtils pageUtils) {
        List<MerchantType> merchantTypeList = new ArrayList<>();
//        pageUtils.setDataCount(this.getCount());
        String sql = "select * from user where enable = 1 LIMIT ?,?";
        Connection conn = DBUtils.getConn();
        User user = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                user = new User();


//                merchantTypeList.add();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  merchantTypeList;
    }

}
