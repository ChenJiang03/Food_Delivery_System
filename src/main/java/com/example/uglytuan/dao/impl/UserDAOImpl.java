package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.UserDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Address;
import com.example.uglytuan.vo.User;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO
{
    private static UserDAOImpl userDAO = new UserDAOImpl();
    private UserDAOImpl(){}
    public static UserDAOImpl getDAO(){
        return userDAO;
    }
    @Override
    public boolean add(User object)
    {
        String sql = "insert into user(username,password,name,picture,phone,address,birthday) values(?,?,?,?,?,?,?)";
        Object[] params = {
                object.getUsername(),
                object.getPassword(),
                object.getName(),
                object.getPicture(),
                object.getPhone(),
                object.getAddress(),
                object.getBirthday()
        };
        return DBUtils.executeUpdate(sql,params);
    }
    @Override
    public boolean delete(User object)
    {
        return false;
    }

//   用户的假删除
    @Override
    public boolean delete(Integer id)
    {
        String sql = "update user set enable = 0 where id = ?";
        return DBUtils.executeUpdate(sql,id);
    }

//批量删除,假删除
    @Override
    public boolean delete(String idStr) {
        String sql="update user set enable=0 where id in("+idStr+")";

        return  DBUtils.executeUpdate(sql);

    }

    @Override
    public boolean recharge(Double balance,int id){
        String sql="update user set balance=balance+? where id=?";
        return DBUtils.executeUpdate(sql,balance,id);
    }

    @Override
    public boolean update(User object) {
        String sql = "update user set username=?,birthday=?,phone=?,address=?,picture=?,name=? where id=?";
        System.out.println(object.getPicture());
        Object[] params={
                object.getUsername(),
                object.getBirthday(),
                object.getPhone(),
                object.getAddress(),
                object.getPicture(),
                object.getName(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean updatePassword(User object){
        String sql = "update user set password=? where id=?";
        Object[] params = {
                object.getPassword(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public User findById(Integer id) {
        String sql = "select * from user where id =?";
        User user = (User) DBUtils.executeQuerySingle(sql,User.class,id);
//        Connection conn = DBUtils.getConn();
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        User user = null;
//        try {
//            ps = conn.prepareStatement(sql);
//            ps.setInt(1,id);
//            rs = ps.executeQuery();
//            while(rs.next()){
//                user = new User();
//                user.setId(rs.getInt("id"));
//                user.setUsername(rs.getString("username"));
//                user.setPassword(rs.getString("password"));
//                user.setName(rs.getString("name"));
//                user.setAddress(rs.getString("address"));
//                user.setBalance(rs.getBigDecimal("balance"));
//                user.setPicture(rs.getString("picture"));
//                user.setPhone(rs.getString("phone"));
//                user.setRegTime(rs.getTimestamp("reg_time"));
//                user.setBirthday(rs.getDate("birthday"));
//            }
//        } catch (SQLException throwables) {
//            throwables.printStackTrace();
//        }finally {
//            DBUtils.closeConn(rs,ps,conn);
//        }
        return user;
    }




    public int getCount(){
        String sql = "select count(*) count from user where enable =1";
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

    public List<User> findPage(PageUtils pageUtils) {
        List<User> userList = new ArrayList<>();
        pageUtils.setDataCount(this.getCount());
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

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setBalance(rs.getBigDecimal("balance"));
                user.setPicture(rs.getString("picture"));
                user.setPhone(rs.getString("phone"));
                user.setRegTime(rs.getTimestamp("reg_time"));
                user.setBirthday(rs.getDate("birthday"));
                userList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  userList;
    }

    @Override
    public List<User> findAll() {
        List<User> userList = new ArrayList<>();
        String sql = "select * from user where enable = 1";
        Connection conn = DBUtils.getConn();
        User user = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setBalance(rs.getBigDecimal("balance"));
                user.setPicture(rs.getString("picture"));
                user.setPhone(rs.getString("phone"));
                user.setRegTime(rs.getTimestamp("reg_time"));
                user.setBirthday(rs.getDate("birthday"));
                userList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }


        return  userList;
    }


    @Override
    public User findByUsernameAndPass(String username, String password) {
        String sql = "select * from user where username=? and password=? and enable=1";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            rs = ps.executeQuery();
            while(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setBalance(rs.getBigDecimal("balance"));
                user.setPicture(rs.getString("picture"));
                user.setPhone(rs.getString("phone"));
                user.setRegTime(rs.getTimestamp("reg_time"));
                user.setBirthday(rs.getDate("birthday"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return user;
    }

    @Override
    public boolean existUser(String username){
        String sql = "select count(*) count from user where username=?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
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

    public List<User> searchUser(String keywords,PageUtils pageUtils){
        pageUtils.setDataCount(this.getCount(keywords));
        String sql="select * from user where enable =1";
        if(keywords!=null&&!keywords.equals("")){
            sql+=" and (name like '%"+keywords+"%'";
            sql+=" or address like '%"+keywords+"%'";
            sql+=" or reg_time like '%"+keywords+"%'";
            sql+=" or username like '%"+keywords+"%')";
        }
        sql+=" limit ?,?";
        List<User> userList = new ArrayList<>();
        Connection conn=DBUtils.getConn();
        User user = null;
        PreparedStatement ps=null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setBalance(rs.getBigDecimal("balance"));
                user.setPicture(rs.getString("picture"));
                user.setPhone(rs.getString("phone"));
                user.setRegTime(rs.getTimestamp("reg_time"));
                user.setBirthday(rs.getDate("birthday"));
                userList.add(user);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return userList;

    }

    public int getCount(String keywords){
        String sql = "select count(*) count from user";
        sql += " where enable=1 and (username like '%"+keywords+"%'";
        sql += " or name like '%"+keywords+"%'";
        sql += " or address like '%"+keywords+"%'";
        sql += " or reg_time like '%"+keywords+"%')";


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
    public boolean subBalance(int userId,BigDecimal needPrice){
        String sql="update user set balance=balance-? where id=?";
        return DBUtils.executeUpdate(sql,needPrice,userId);
    }
}
