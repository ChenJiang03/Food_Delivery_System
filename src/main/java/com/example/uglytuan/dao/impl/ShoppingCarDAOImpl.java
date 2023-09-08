package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.ShoppingCarDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShoppingCarDAOImpl implements ShoppingCarDAO
{

    private static ShoppingCarDAOImpl shoppingCarDAO = new ShoppingCarDAOImpl();
    private ShoppingCarDAOImpl(){}
    public static ShoppingCarDAOImpl getDAO(){
        return shoppingCarDAO;
    }
    @Override
    public boolean add(ShoppingCar object)
    {
        String sql = "insert into shopping_car(user_id,merchant_id,product_id,amount) values(?,?,?,?)";
        Object[] params = {
                object.getUserId(),
                object.getMerchantId(),
                object.getProductId(),
                object.getAmount()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(ShoppingCar object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "delete from shopping_car where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "delete from shopping_car where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(ShoppingCar object)
    {

        return false;
    }

    @Override
    public ShoppingCar findById(Integer id)
    {
        String sql = "select * from shopping_car where id=?";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ShoppingCar shoppingCar = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs = ps.executeQuery();

            while(rs.next()){
                shoppingCar = new ShoppingCar();
                shoppingCar.setId(rs.getInt("id"));
                shoppingCar.setAmount(rs.getInt("amount"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));

                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("merchant_id"));

                shoppingCar.setMerchant(merchant);
                shoppingCar.setProduct(product);

            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return shoppingCar;
    }

    @Override
    public List<ShoppingCar> findAll() {
        return null;
    }

    public List<ShoppingCar> findAllMerchant(int userId){
        List<ShoppingCar> shoppingCarList = new ArrayList<>();
        String sql = "select distinct sc.merchant_id,m.name merchant_name from shopping_car sc,merchant m where user_id=? and m.id=sc.merchant_id";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,userId);
            rs = ps.executeQuery();
            while(rs.next()){
                ShoppingCar shoppingCar = new ShoppingCar();
                shoppingCar.setMerchantId(rs.getInt("merchant_id"));
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("merchant_id"));
                merchant.setName(rs.getString("merchant_name"));
                shoppingCar.setMerchant(merchant);
                shoppingCarList.add(shoppingCar);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return shoppingCarList;
    }

    public List<ShoppingCar> findAll(int userId,int merchantId)
    {
        List<ShoppingCar> shoppingCarList = new ArrayList<>();
        String sql = "select sc.*,m.name merchant_name,p.price product_price,p.title product_title,p.picture product_picture";
        sql += " from shopping_car sc,merchant m,product p";
        sql += " where sc.product_id=p.id and sc.merchant_id=m.id and sc.enable=1 and sc.user_id=? and sc.merchant_id=?";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,merchantId);
            rs = ps.executeQuery();
            while(rs.next()){
                ShoppingCar shoppingCar = new ShoppingCar();
                shoppingCar.setId(rs.getInt("id"));
                shoppingCar.setAmount(rs.getInt("amount"));
                shoppingCar.setUserId(rs.getInt("user_id"));

                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("merchant_id"));
                merchant.setName(rs.getString("merchant_name"));
                shoppingCar.setMerchant(merchant);

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setPrice(rs.getDouble("product_price"));
                product.setTitle(rs.getString("product_title"));
                product.setPicture(rs.getString("product_picture"));
                shoppingCar.setProduct(product);

                shoppingCarList.add(shoppingCar);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return shoppingCarList;
    }

    public ShoppingCar exist(int productId,int userId){
        String sql = "select * from shopping_car where user_id=? and product_id=? and enable=1";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ShoppingCar shoppingCar = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,productId);
            rs = ps.executeQuery();

            while(rs.next()){
                shoppingCar = new ShoppingCar();
                shoppingCar.setId(rs.getInt("id"));
                shoppingCar.setUserId(rs.getInt("user_id"));
                shoppingCar.setMerchantId(rs.getInt("merchant_id"));
                shoppingCar.setProductId(rs.getInt("product_id"));
                shoppingCar.setAmount(rs.getInt("amount"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return shoppingCar;
    }

    public boolean addNum(int num,int shoppingCarId){
        String sql="update shopping_car set amount=amount+? where id=?";
        return DBUtils.executeUpdate(sql,num,shoppingCarId);
    }

    public boolean change(int shoppingCarId){
        String sql = "update shopping_car set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,shoppingCarId);
    }


}
