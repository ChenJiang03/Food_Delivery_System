package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.MerchantDAO;
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
import java.util.Date;
import java.util.List;

public class MerchantDAOImpl implements MerchantDAO {

    private MerchantDAOImpl(){}
    private static MerchantDAOImpl dao = new MerchantDAOImpl();

    public static MerchantDAOImpl getDao()
    {
        return dao;
    }

    @Override
    public boolean add(Merchant merchant)
    {
        String sql="insert into merchant(username,password,address,phone,name,picture,boss_name,boss_phone,boss_id,certificate,merchant_type_id,province_id,city_id,district_id) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Object[] params={
                merchant.getUsername(),
                merchant.getPassword(),
                merchant.getAddress(),
                merchant.getPhone(),
                merchant.getName(),
                merchant.getPicture(),
                merchant.getBossName(),
                merchant.getBossPhone(),
                merchant.getBossId(),
                merchant.getCertificate(),
                merchant.getMerchantTypeId(),
                merchant.getProvinceId(),
                merchant.getCityId(),
                merchant.getDistrictId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(Merchant object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql="update merchant set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql="update merchant set enable=0 where id in ("+ids+")";
        return DBUtils.executeUpdate(sql);
    }

    @Override
    public boolean updateCenter(Merchant merchant){
        String sql="update merchant set address=?,phone=?,name=?,boss_phone=?,picture=?,province_id=?,city_id=?,district_id=?,merchant_type_id=? where id=?";
        Object[] params={
                merchant.getAddress(),
                merchant.getPhone(),
                merchant.getName(),
                merchant.getBossPhone(),
                merchant.getPicture(),
                merchant.getProvinceId(),
                merchant.getCityId(),
                merchant.getDistrictId(),
                merchant.getMerchantTypeId(),
                merchant.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean recharge(Double balance,int id){
        String sql="update merchant set balance=balance+? where id=?";
        return DBUtils.executeUpdate(sql,balance,id);
    }


    @Override
    public boolean updatePass(Merchant merchant){
        String sql="update merchant set password=? where id=?";
        Object[] params={
                merchant.getPassword(),
                merchant.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean auditOk(int id){
        String sql="update merchant set check1=1 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

//    @Override
//    public List<Merchant> findAll(PageUtils pageUtils) {
//        pageUtils.setDataCount(this.getCount());
//        List<Merchant> merchantList = new ArrayList<>();
//        String sql = "select m.*,mt.type merchant_type_name";
//        sql += " from merchant m,merchant_type mt";
//        sql += " where m.merchant_type_id=mt.id and m.enable=1 and check1=1 ";
//        sql += " limit ?,?";
//        Connection conn = DBUtils.getConn();
//        Merchant merchant = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        try {
//            ps = conn.prepareStatement(sql);
//            ps.setInt(1,pageUtils.getFirstRow());
//            ps.setInt(2,pageUtils.getPageSize());
//            rs = ps.executeQuery();
//            while (rs.next()){
//                merchant = new Merchant();
//                merchant.setId(rs.getInt("id"));
//                merchant.setUsername(rs.getString("username"));
//                merchant.setPassword(rs.getString("password"));
//                merchant.setName(rs.getString("name"));
//                merchant.setAddress(rs.getString("address"));
//                merchant.setBalance(rs.getDouble("balance"));
//                merchant.setPicture(rs.getString("picture"));
//                merchant.setPhone(rs.getString("phone"));
//                merchant.setRegTime(rs.getTimestamp("reg_time"));
//                merchant.setCertificate(rs.getString("certificate"));
//                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
//                merchant.setBossId(rs.getString("boss_id"));
//                merchant.setBossName(rs.getString("boss_name"));
//                merchant.setBossPhone(rs.getString("boss_phone"));
//                merchant.setCheck(rs.getBoolean("check1"));
//                merchant.setScore(rs.getDouble("score"));
//                merchant.setDescription(rs.getString("description"));
//                merchant.setEnable(rs.getInt("enable"));
////                merchant.setProvinceId(rs.getString("province_id"));
////                merchant.setCityId(rs.getString("city_id"));
////                merchant.setDistrictId(rs.getString("district_id"));
//
//                MerchantType merchantType = new MerchantType();
//                merchantType.setId(rs.getInt("merchant_type_id"));
//                merchantType.setType(rs.getString("merchant_type_name"));
//
//                ProductType productType = new ProductType();
//                productType.setId(rs.getInt("product_type_id"));
//                productType.setTitle(rs.getString("product_type_title"));
//
//                merchant.setProductType(productType);
//                merchant.setMerchantType(merchantType);
//                merchantList.add(merchant);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            DBUtils.closeConn(rs,ps,conn);
//        }
//        return  merchantList;
//
//    }


    @Override
    public boolean update(Merchant merchant)
    {
        String sql="update merchant set password=?,address=?,phone=?,name=?,boss_phone=?,picture=?,description=?,province_id=?,city_id=?,district_id=?,merchant_type_id=? where id=?";
        Object[] params={
                merchant.getPassword(),
                merchant.getAddress(),
                merchant.getPhone(),
                merchant.getName(),
                merchant.getBossPhone(),
                merchant.getPicture(),
                merchant.getDescription(),
                merchant.getProvinceId(),
                merchant.getCityId(),
                merchant.getDistrictId(),
                merchant.getMerchantTypeId(),
                merchant.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public Merchant findById(Integer id)
    {
        String sql = "select * from merchant where enable=1 and id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Merchant merchant=null;

        try {
            ps=conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                merchant=new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return merchant;
    }

    @Override
    public List<Merchant> search(int merchantTypeId, String keyword,String minTime,String maxTime){
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select * from merchant where enable=1 and check1=1";
        if(merchantTypeId!=0){
            sql+=" and merchant_type_id="+merchantTypeId;
        }
        if(keyword!=null&&!keyword.equals("")){
            sql+=" and name like '%"+keyword+"%'";
        }
        if(minTime!=null&&!minTime.equals("")){
            sql+=" and reg_time > '"+minTime+"'";
        }
        if(maxTime!=null&&!maxTime.equals("")){
            sql+=" and reg_time < '"+maxTime+"'";
        }

        Connection conn = DBUtils.getConn();
        Merchant merchant = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));
                merchantList.add(merchant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  merchantList;
    }


    @Override
    public List<Merchant> findAll() {

        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select m.*,mt.type merchant_type_name";
        sql += " from merchant m,merchant_type mt";
        sql += " where m.merchant_type_id=mt.id and m.enable=1 and m.check1=1";
        Connection conn = DBUtils.getConn();
        Merchant merchant = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));

                MerchantType merchantType = new MerchantType();
                merchantType.setId(rs.getInt("merchant_type_id"));
                merchantType.setType(rs.getString("merchant_type_name"));

                merchant.setMerchantType(merchantType);
                merchantList.add(merchant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  merchantList;
    }


    @Override
    public List<Merchant> findAllCheck(PageUtils pageUtils) {
        pageUtils.setDataCount(this.getCountCheck());
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select * from merchant where enable=1 and check1=0";
        sql += " limit ?,?";
        Connection conn = DBUtils.getConn();
        Merchant merchant = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));

                merchantList.add(merchant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  merchantList;

    }


    @Override
    public List<Merchant> findAll(PageUtils pageUtils) {
        pageUtils.setDataCount(this.getCount());
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select m.*,mt.type merchant_type_name";
        sql += " from merchant m,merchant_type mt";
        sql += " where m.merchant_type_id=mt.id and m.enable=1";
        sql += " limit ?,?";
        Connection conn = DBUtils.getConn();
        Merchant merchant = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));

                MerchantType merchantType = new MerchantType();
                merchantType.setId(rs.getInt("merchant_type_id"));
                merchantType.setType(rs.getString("merchant_type_name"));

                merchant.setMerchantType(merchantType);
                merchantList.add(merchant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  merchantList;

    }

    @Override
    public Merchant findByUserAndPass(String username, String password) {
        String sql="select * from merchant where username=? and password=? and check1=1 ";

        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Merchant findMerchant=null;
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            rs=ps.executeQuery();

            if(rs.next()){
                findMerchant=new Merchant();
                findMerchant.setId(rs.getInt("id"));
                findMerchant.setUsername(rs.getString("username"));
                findMerchant.setPassword(rs.getString("password"));
                findMerchant.setAddress(rs.getString("address"));
                findMerchant.setPhone(rs.getString("phone"));
                findMerchant.setName(rs.getString("name"));
                findMerchant.setRegTime(rs.getTimestamp("reg_time"));
                findMerchant.setEnable(rs.getInt("enable"));
                findMerchant.setBossName(rs.getString("boss_name"));
                findMerchant.setBossPhone(rs.getString("boss_phone"));
                findMerchant.setBossId(rs.getString("boss_id"));
                findMerchant.setCertificate(rs.getString("certificate"));
                findMerchant.setPicture(rs.getString("picture"));
                findMerchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                findMerchant.setDescription(rs.getString("description"));
                findMerchant.setBalance(rs.getDouble("balance"));
                findMerchant.setCheck(rs.getBoolean("check1"));
                findMerchant.setScore(rs.getDouble("score"));
                findMerchant.setProvinceId(rs.getString("province_id"));
                findMerchant.setCityId(rs.getString("city_id"));
                findMerchant.setDistrictId(rs.getString("district_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return findMerchant;
    }


    /*
    * 查询显示列表的总条数*/
    public int getCount(){
        String sql = "select count(*) count from merchant where enable =1 and check1=1 ";
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

    public int getCountCheck(){
        String sql = "select count(*) count from merchant where enable =1 and check1=0 ";
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


    //前台查询
    public List<Merchant> search(int districtId,int merchantTypeId){
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select m.*,mt.type merchant_type_name from merchant m,merchant_type mt where m.merchant_type_id=mt.id and m.enable=1";
        if(districtId != 0){
            sql+=" and district_id="+districtId;
        }
        if(merchantTypeId != 0){
            sql += " and merchant_type_id="+merchantTypeId;
        }

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));

                MerchantType merchantType = new MerchantType();
                merchantType.setId(rs.getInt("merchant_type_id"));
                merchantType.setType(rs.getString("merchant_type_name"));
                merchant.setMerchantType(merchantType);
                merchantList.add(merchant);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return merchantList;
    }

    public int getCount(String keywords,int merchantTypeId,String minTime,String maxTime){
        String sql = "select count(*) count from merchant";
        sql += " where enable=1 and check1=1";
        if(keywords!=null&&!keywords.equals("")){
            sql+=  " and (username like '%"+keywords+"%'";
            sql += " or name like '%"+keywords+"%'";
            sql += " or boss_id like '%"+keywords+"%'";
            sql += " or boss_phone like '%"+keywords+"%')";
        }
        if(merchantTypeId!=0){
            sql += " and merchant_type_id="+merchantTypeId;
        }
        if(minTime!=null&&!minTime.equals("")){
            sql+=" and reg_time > '"+minTime+"'";
        }
        if(maxTime!=null&&!maxTime.equals("")){
            sql+=" and reg_time < '"+maxTime+"'";
        }

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

    public List<Merchant> search2(String keywords,int merchantTypeId,PageUtils pageUtils,String minTime,String maxTime){
        pageUtils.setDataCount(this.getCount(keywords, merchantTypeId,minTime,maxTime));
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select * from merchant where enable=1 and check1=1";
        if(keywords!=null&&!keywords.equals("")){
            sql += " and name like '%"+keywords+"%'";

        }
        if(merchantTypeId != 0){
            sql += " and merchant_type_id="+merchantTypeId;
        }
        if(minTime!=null&&!minTime.equals("")){
            sql+=" and reg_time > '"+minTime+"'";
        }
        if(maxTime!=null&&!maxTime.equals("")){
            sql+=" and reg_time < '"+maxTime+"'";
        }
        sql += " limit ?,?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while(rs.next()){
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));
                merchantList.add(merchant);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return merchantList;
    }

    public List<Merchant> search3(String keywords){
        List<Merchant> merchantList = new ArrayList<>();
        String sql = "select m.*,mt.type merchant_type_name from merchant m,merchant_type mt where m.merchant_type_id=mt.id and m.enable=1 and check1=1 ";
        if(keywords!=null&&!keywords.equals("")){
            sql += " and name like '%"+keywords+"%'";

        }

        System.out.println(sql);

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));

                MerchantType merchantType = new MerchantType();
                merchantType.setId(rs.getInt("merchant_type_id"));
                merchantType.setType(rs.getString("merchant_type_name"));
                merchant.setMerchantType(merchantType);
                merchantList.add(merchant);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return merchantList;
    }

    public List<Merchant> findByTime(){
        String sql = "select m.*,mt.type merchant_type_name from merchant m,merchant_type mt where m.merchant_type_id=mt.id and m.enable=1 order by reg_time DESC ";
        List<Merchant> merchantList = new ArrayList<>();

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Merchant merchant = new Merchant();
                merchant.setId(rs.getInt("id"));
                merchant.setUsername(rs.getString("username"));
                merchant.setPassword(rs.getString("password"));
                merchant.setName(rs.getString("name"));
                merchant.setAddress(rs.getString("address"));
                merchant.setBalance(rs.getDouble("balance"));
                merchant.setPicture(rs.getString("picture"));
                merchant.setPhone(rs.getString("phone"));
                merchant.setRegTime(rs.getTimestamp("reg_time"));
                merchant.setCertificate(rs.getString("certificate"));
                merchant.setMerchantTypeId(rs.getInt("merchant_type_id"));
                merchant.setBossId(rs.getString("boss_id"));
                merchant.setBossName(rs.getString("boss_name"));
                merchant.setBossPhone(rs.getString("boss_phone"));
                merchant.setCheck(rs.getBoolean("check1"));
                merchant.setScore(rs.getDouble("score"));
                merchant.setDescription(rs.getString("description"));
                merchant.setEnable(rs.getInt("enable"));
                merchant.setProvinceId(rs.getString("province_id"));
                merchant.setCityId(rs.getString("city_id"));
                merchant.setDistrictId(rs.getString("district_id"));

                MerchantType merchantType = new MerchantType();
                merchantType.setId(rs.getInt("merchant_type_id"));
                merchantType.setType(rs.getString("merchant_type_name"));
                merchant.setMerchantType(merchantType);
                merchantList.add(merchant);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return merchantList;
    }

}
