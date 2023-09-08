package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.FavouriteDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.vo.Favourite;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavouriteDAOImpl implements FavouriteDAO
{
    private static FavouriteDAOImpl favouriteDAO = new FavouriteDAOImpl();
    private FavouriteDAOImpl(){}
    public static FavouriteDAOImpl getDAO(){
        return favouriteDAO;
    };
    @Override
    public boolean add(Favourite object)
    {

        String sql = "insert into favourite(user_id,merchant_id) values(?,?)";
        return DBUtils.executeUpdate(sql,object.getUser().getId(),object.getMerchant().getId());
    }

    @Override
    public boolean delete(Favourite object)
    {
        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "delete from favourite where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update favourite set enable=0 where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(Favourite object)
    {

        return false;
    }

    @Override
    public Favourite findById(Integer id)
    {
        return null;
    }

    @Override
    public List<Favourite> findAll()
    {
        List<Favourite> favouriteList = new ArrayList<>();
        String sql = "select f.*,m.name merchant_name,m.picture merchant_picture from favourite f,merchant m";
        sql += " where f.merchant_id=m.id";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Favourite favourite = new Favourite();
                favourite.setId(rs.getInt("id"));
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("merchant_id"));
                merchant.setName(rs.getString("merchant_name"));
                merchant.setPicture(rs.getString("merchant_picture"));
                User user = new User();
                user.setId(rs.getInt("user_id"));
                favourite.setUser(user);
                favourite.setMerchant(merchant);
                favouriteList.add(favourite);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return favouriteList;
    }

    public boolean existSame(int merchantId){
        String sql = "select count(*) count from favourite where merchant_id=?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,merchantId);
            rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("count")>0;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return false;
    }
}
