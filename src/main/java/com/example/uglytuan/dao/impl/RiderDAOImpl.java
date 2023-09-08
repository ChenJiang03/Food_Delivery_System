package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.RiderDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Rider;
import com.example.uglytuan.vo.SysArea;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RiderDAOImpl implements RiderDAO
{
    private static RiderDAOImpl riderDAOImpl = new RiderDAOImpl();
    private RiderDAOImpl()
    {
    }
    public static RiderDAOImpl getRiderDAO()
    {
        return riderDAOImpl;
    }

    public int getCount(){
        String sql="SELECT count(*) count FROM rider WHERE enable=1";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            ps=conn.prepareStatement(sql);
            rs= ps.executeQuery();
            if (rs.next()){
                return rs.getInt("count");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            DBUtils.closeConn(rs,ps,conn);
        }
        return 0;
    }

    @Override
    public boolean add(Rider object)
    {
        String sql = "insert into rider(username,password,phone,name,identification,picture,province_id, city_id, district_id) values(?,?,?,?,?,?,?,?,?)";
        return DBUtils.executeUpdate(sql, object.getUsername(), object.getPassword(), object.getPhone(), object.getName(), object.getIdentification(), object.getPicture(), object.getProvince().getId(), object.getCity().getId(), object.getDistrict().getId());
    }

    @Override
    public boolean delete(Rider object)
    {
        String sql = "update rider set enable=? where id=?";
        Object[] params={
                0,
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update rider set enable=0 where id=?";
        Object[] params={
                id
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update rider set enable=0 where id in ("+ids+")";
        //Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql);
    }

    @Override
    public boolean update(Rider object)
    {
        String sql = "update rider set username=?, password=?, phone=?, name=?, balance=?, identification=?, score=?, picture=?, available=?, province_id=?, city_id=?, district_id=? where id=?";
        Object[] params={
                object.getUsername(),
                object.getPassword(),
                object.getPhone(),
                object.getName(),
                object.getBalance(),
                object.getIdentification(),
                object.getScore(),
                object.getPicture(),
                object.getAvailable(),
                object.getProvince().getId(),
                object.getCity().getId(),
                object.getDistrict().getId(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql, params);
    }
    @Override
    public boolean updatePassword(Rider object, String newPassword)
    {
        String sql = "update rider set password=? where id=?";
        Object[] params={
                newPassword,
                object.getId()
        };
        return DBUtils.executeUpdate(sql, params);
    }
    public boolean existRider(String username)
    {
        String sql = "select id from rider where username=?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,username);
            rs=ps.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            DBUtils.closeConn(rs,ps,conn);
        }
        return false;
    }
    @Override
    public Rider findById(Integer id)
    {
        String sql = "select * from rider where id=?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Rider findRider = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next())
            {
                findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));

            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return findRider;
    }
    public Rider findByUsernameAndPass(String username, String password)
    {
        String sql = "select * from rider where username=? and password=? and enable=1";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Rider findRider = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next())
            {
                findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));
            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return findRider;
    }

    @Override
    public List<Rider> findAll()
    {
        String sql = "select * from rider where enable = 1";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Rider> riderList = new ArrayList<>();
        try
        {
            ps=conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next())
            {
                Rider findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));
//                System.out.println(findRider);
                riderList.add(findRider);
            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return riderList;
    }

    @Override
    public List<Rider> findAll(PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount());
        String sql = "select * from rider where enable = 1 limit ?,?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Rider> riderList = new ArrayList<>();
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Rider findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));
                riderList.add(findRider);
            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return riderList;
    }

    public List<Rider> findByDistrictId(String district_id)
    {
        String sql = "select * from rider where enable = 1 and district_id="+district_id;
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Rider> riderList = new ArrayList<>();
        try
        {
            ps=conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next())
            {
                Rider findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));
//                System.out.println(findRider);
                riderList.add(findRider);
            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return riderList;
    }

    @Override
    public List<Rider> findByCondition(String condition,PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount(condition));
        String sql = "select * from rider "+condition;
        sql += " limit ?,?";
        System.out.println("select * from rider "+condition);
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Rider> riderList = new ArrayList<>();
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Rider findRider = new Rider();
                findRider.setId(rs.getInt("id"));
                findRider.setUsername(rs.getString("username"));
                findRider.setPassword(rs.getString("password"));
                findRider.setPhone(rs.getString("phone"));
                findRider.setName(rs.getString("name"));
                findRider.setEnable(rs.getBoolean("enable"));
                findRider.setBalance(rs.getDouble("balance"));
                findRider.setIdentification(rs.getString("identification"));
                findRider.setScore(rs.getDouble("score"));
                findRider.setPicture(rs.getString("picture"));
                findRider.setAvailable(rs.getBoolean("available"));
                findRider.setRegTime(rs.getDate("reg_time"));
                SysArea province = SysAreaDAOImpl.getDao().findById(rs.getString("province_id"));
                SysArea city = SysAreaDAOImpl.getDao().findById(rs.getString("city_id"));
                SysArea district = SysAreaDAOImpl.getDao().findById(rs.getString("district_id"));
                findRider.setProvince(province);
                findRider.setCity(city);
                findRider.setDistrict(district);
                findRider.setCurrent_orders(rs.getInt("current_orders"));
                System.out.println(findRider);
                riderList.add(findRider);
            }
        }
        catch (SQLException throwables)
        {
            throwables.printStackTrace();
        }
        finally
        {
            DBUtils.closeConn(rs,ps,conn);
        }
        return riderList;
    }

    public int getCount(String condition){
        String sql="SELECT count(*) count FROM rider "+condition;
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            ps=conn.prepareStatement(sql);
            rs= ps.executeQuery();
            if (rs.next()){
                return rs.getInt("count");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            DBUtils.closeConn(rs,ps,conn);
        }
        return 0;
    }
}
