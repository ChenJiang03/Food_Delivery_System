package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.ProductDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO
{
    private ProductDAOImpl(){}
    private static ProductDAOImpl dao = new ProductDAOImpl();

    public static ProductDAOImpl getDao()
    {
        return dao;
    }
    @Override
    public boolean add(Product product)
    {
        String sql="insert into product(title,description,picture,merchant_id,price,stock,product_type_id) value(?,?,?,?,?,?,?)";
        Object[] params={
                product.getTitle(),
                product.getDescription(),
                product.getPicture(),
                product.getMerchantId(),
                product.getPrice(),
                product.getStock(),
                product.getProductTypeId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(Product object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update product set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update product set enable=0 where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(Product object)
    {

        return false;
    }

    @Override
    public boolean updateById(Product product)
    {
        String sql="update product set title=?,price=?,stock=?,description=?,picture=?,product_type_id=? where id=?";
        Object[] params={
                product.getTitle(),
                product.getPrice(),
                product.getStock(),
                product.getDescription(),
                product.getPicture(),
                product.getProductTypeId(),
                product.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public List<Product> findByMerchantId(Integer id,PageUtils pageUtils){
        pageUtils.setDataCount(this.getCount(id));
        List<Product> productList = new ArrayList<>();
        String sql ="select * from product where enable=1 and merchant_id=?";
        sql +=" limit ?,?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Product product=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            ps.setInt(2,pageUtils.getFirstRow());
            ps.setInt(3,pageUtils.getPageSize());
            rs=ps.executeQuery();
            while (rs.next()){
                product=new Product();
                product.setId(rs.getInt("id"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPicture(rs.getString("picture"));
                product.setMerchantId(rs.getInt("merchant_id"));
                product.setEnable(rs.getBoolean("enable"));
                product.setStock(rs.getBoolean("stock"));
                product.setProductTypeId(rs.getInt("product_type_id"));
                product.setPrice(rs.getDouble("price"));
                productList.add(product);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return productList;
    }

    public int getCount(Integer id){
        String sql = "select count(*) count from product where enable =1 and merchant_id="+id;
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

    @Override
    public List<Product> findByMerchantId(Integer id){
        List<Product> productList = new ArrayList<>();
        String sql ="select * from product where enable=1 and merchant_id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Product product=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                product=new Product();
                product.setId(rs.getInt("id"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPicture(rs.getString("picture"));
                product.setMerchantId(rs.getInt("merchant_id"));
                product.setEnable(rs.getBoolean("enable"));
                product.setStock(rs.getBoolean("stock"));
                product.setProductTypeId(rs.getInt("product_type_id"));
                product.setPrice(rs.getDouble("price"));
                productList.add(product);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return productList;
    }

    @Override
    public Product findById(Integer id)
    {
        String sql ="select p.*,m.address merchant_address from product p,merchant m where p.id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Product product=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                product=new Product();
                product.setId(rs.getInt("id"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPicture(rs.getString("picture"));
                product.setMerchantId(rs.getInt("merchant_id"));
                product.setEnable(rs.getBoolean("enable"));
                product.setStock(rs.getBoolean("stock"));
                product.setProductTypeId(rs.getInt("product_type_id"));
                product.setPrice(rs.getDouble("price"));

                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("merchant_id"));
                merchant.setAddress(rs.getString("merchant_address"));
                product.setMerchant(merchant);
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return product;
    }

    @Override
    public List<Product> findAll()
    {
        return null;
    }
}
