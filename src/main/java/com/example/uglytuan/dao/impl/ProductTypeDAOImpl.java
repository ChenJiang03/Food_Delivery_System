package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.ProductTypeDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Product;
import com.example.uglytuan.vo.ProductType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductTypeDAOImpl implements ProductTypeDAO
{

    private ProductTypeDAOImpl(){}
    private static ProductTypeDAOImpl dao = new ProductTypeDAOImpl();

    public static ProductTypeDAOImpl getDao()
    {
        return dao;
    }
    @Override
    public boolean add(ProductType productType)
    {
        String sql="insert into product_type(title,description) value(?,?)";
        Object[] params={
                productType.getTitle(),
                productType.getDescription()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(ProductType object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update product_type set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update product_type set enable=0 where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(ProductType productType)
    {
        String sql="update product_type set title=?,description=? where id=?";
        Object[] params={
                productType.getTitle(),
                productType.getDescription(),
                productType.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public ProductType findById(Integer id)
    {
        String sql ="select * from product_type where enable=1 and id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        ProductType productType=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                productType=new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setTitle(rs.getString("title"));
                productType.setDescription(rs.getString("description"));
                productType.setEnable(rs.getBoolean("enable"));
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return productType;
    }

    @Override
    public List<ProductType> findAll()
    {
        List<ProductType> productTypeList=new ArrayList<>();

        String sql ="select * from product_type where enable=1";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        ProductType productType=null;

        try {
            ps=conn.prepareStatement(sql);
            rs=ps.executeQuery();
            while (rs.next()){
                productType=new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setTitle(rs.getString("title"));
                productType.setDescription(rs.getString("description"));
                productType.setEnable(rs.getBoolean("enable"));
                productTypeList.add(productType);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return productTypeList;
    }

    @Override
    public List<ProductType> findAll(PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount());
        List<ProductType> productTypeList=new ArrayList<>();


        String sql ="select * from product_type where enable=1";
        sql +=" limit ?,?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        ProductType productType=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs=ps.executeQuery();
            while (rs.next()){
                productType=new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setTitle(rs.getString("title"));
                productType.setDescription(rs.getString("description"));
                productType.setEnable(rs.getBoolean("enable"));
                productTypeList.add(productType);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return productTypeList;
    }

    public int getCount(){
        String sql = "select count(*) count from product_type where enable =1 ";
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
}
