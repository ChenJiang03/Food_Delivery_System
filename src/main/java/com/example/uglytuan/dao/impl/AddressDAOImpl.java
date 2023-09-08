package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.AddressDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Address;
import com.example.uglytuan.vo.SysArea;
import com.example.uglytuan.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAOImpl implements AddressDAO
{
    private AddressDAOImpl(){}
    private static AddressDAOImpl dao = new AddressDAOImpl();

    public static AddressDAOImpl getDao()
    {
        return dao;
    }

    @Override
    public void updateDefault(Integer id)
    {

    }

    /*
     方法参数：Address address
     */
    @Override
    public boolean add(Address address){
        String sql="insert into address(name,phone,address,province_id,city_id,district_id,user_id,is_default) values(?,?,?,?,?,?,?,?)";
        Object[] params={
                address.getName(),
                address.getPhone(),
                address.getAddress(),
                address.getProvince().getId(),
                address.getCity().getId(),
                address.getDistrict().getId(),
                address.getUser().getId(),
                address.getIsDefault()
        };
        return DBUtils.executeUpdate(sql,params);
    }


    @Override
    public boolean delete(Address object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update address set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update address set enable=0 where id=?";
        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean update(Address address){
        String sql="update address set name=?,phone=?,address=?,province_id=?,city_id=?,district_id=?,is_default=? where id=?";
        Object[] params={
                address.getName(),
                address.getPhone(),
                address.getAddress(),
                address.getProvince().getId(),
                address.getCity().getId(),
                address.getDistrict().getId(),
                address.getIsDefault(),
                address.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }


    @Override
    public Address findById(Integer id){
        StringBuffer sql=new StringBuffer();
        sql.append("SELECT a.*,p.name province_name,c.name city_name,d.name district_name");
        sql.append(" FROM address a,sys_area p,sys_area c,sys_area d");
        sql.append(" WHERE a.province_id=p.id");
        sql.append(" AND a.city_id=c.id");
        sql.append(" AND a.district_id=d.id and a.id=?");
        Address address=null;
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            ps=conn.prepareStatement(sql.toString());
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while(rs.next()){
                address=new Address();
                address.setId(rs.getInt("id"));
                address.setName(rs.getString("name"));
                address.setPhone(rs.getString("phone"));

                User user=new User();
                user.setId(rs.getInt("user_id"));
                address.setUser(user);

                SysArea province=new SysArea();
                province.setId(rs.getString("province_id"));
                province.setName(rs.getString("province_name"));
                address.setProvince(province);

                SysArea city=new SysArea();
                city.setId(rs.getString("city_id"));
                city.setName(rs.getString("city_name"));
                address.setCity(city);

                SysArea district=new SysArea();
                district.setId(rs.getString("district_id"));
                district.setName(rs.getString("district_name"));
                address.setDistrict(district);

                address.setDefault(rs.getBoolean("is_default"));
                address.setAddress(rs.getString("address"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return address;
    }

    @Override
    public List<Address> findAll() {
        return null;
    }

    @Override
    public List<Address> findAll(int userId,PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount(userId));
        StringBuffer sql=new StringBuffer();
        sql.append("SELECT a.*,p.name province_name,c.name city_name,d.name district_name");
        sql.append(" FROM address a,sys_area p,sys_area c,sys_area d");
        sql.append(" WHERE a.province_id=p.id");
        sql.append(" AND a.city_id=c.id");
        sql.append(" AND a.district_id=d.id and a.user_id=? and enable=1");
        sql.append(" limit ?,?");
        ArrayList<Address> addressList=new ArrayList<>();
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            ps=conn.prepareStatement(sql.toString());
            ps.setInt(1,userId);
            ps.setInt(2,pageUtils.getFirstRow());
            ps.setInt(3,pageUtils.getPageSize());
            rs=ps.executeQuery();
            while(rs.next()){
                Address address=new Address();
                address.setId(rs.getInt("id"));
                address.setName(rs.getString("name"));
                address.setPhone(rs.getString("phone"));

                User user=UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                address.setUser(user);

                SysArea province=new SysArea();
                province.setId(rs.getString("province_id"));
                province.setName(rs.getString("province_name"));
                address.setProvince(province);

                SysArea city=new SysArea();
                city.setId(rs.getString("city_id"));
                city.setName(rs.getString("city_name"));
                address.setCity(city);

                SysArea district=new SysArea();
                district.setId(rs.getString("district_id"));
                district.setName(rs.getString("district_name"));

                System.out.println(district.getName());

                address.setDistrict(district);

                address.setDefault(rs.getBoolean("is_default"));
                address.setAddress(rs.getString("address"));

                addressList.add(address);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return addressList;
    }

    public List<Address> findAll(int userId){
        StringBuffer sql=new StringBuffer();
        sql.append("SELECT a.*,p.name province_name,c.name city_name,d.name district_name");
        sql.append(" FROM address a,sys_area p,sys_area c,sys_area d");
        sql.append(" WHERE a.province_id=p.id");
        sql.append(" AND a.city_id=c.id");
        sql.append(" AND a.district_id=d.id and a.user_id=? and enable=1");
        ArrayList<Address> addressList=new ArrayList<>();
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            ps=conn.prepareStatement(sql.toString());
            ps.setInt(1,userId);
            rs=ps.executeQuery();
            while(rs.next()){
                Address address=new Address();
                address.setId(rs.getInt("id"));
                address.setName(rs.getString("name"));
                address.setPhone(rs.getString("phone"));

                User user=UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                address.setUser(user);

                SysArea province=new SysArea();
                province.setId(rs.getString("province_id"));
                province.setName(rs.getString("province_name"));
                address.setProvince(province);

                SysArea city=new SysArea();
                city.setId(rs.getString("city_id"));
                city.setName(rs.getString("city_name"));
                address.setCity(city);

                SysArea district=new SysArea();
                district.setId(rs.getString("district_id"));
                district.setName(rs.getString("district_name"));

                System.out.println(district.getName());

                address.setDistrict(district);

                address.setDefault(rs.getBoolean("is_default"));
                address.setAddress(rs.getString("address"));

                addressList.add(address);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return addressList;
    }

    public boolean resetDefaultAddress(){
        String sql="update address set is_default=0";
        return DBUtils.executeUpdate(sql);
    }

    public boolean setDefaultAddress(int id){
        String sql="update address set is_default=1 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    public int getCount(int userId){
        String sql = "SELECT COUNT(*) count";
        sql += " FROM address a,sys_area p,sys_area c,sys_area d";
        sql += " WHERE a.province_id=p.id AND a.city_id=c.id AND a.district_id=d.id AND enable=1 AND user_id=?";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,userId);
            rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("count");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return 0;
    }

}
