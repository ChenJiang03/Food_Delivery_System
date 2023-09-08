package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.OrdersDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.*;

import javax.persistence.criteria.CriteriaBuilder;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrdersDAOImpl implements OrdersDAO
{
    private OrdersDAOImpl(){}
    private static OrdersDAOImpl dao = new OrdersDAOImpl();

    public static OrdersDAOImpl getDao()
    {
        return dao;
    }

    @Override
    public boolean add(Orders object)
    {
        String sql = "insert into orders(user_id,merchant_id,order_status,total_price,complicated_id,user_province_id,user_city_id,user_district_id,user_address_detail,merchant_province_id,merchant_city_id,merchant_district_id,merchant_address_detail) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Object[] params={
                object.getUser().getId(),
                object.getMerchant().getId(),
                object.getOrderStatus(),
                object.getTotalPrice(),
                object.getComplicatedId(),
                object.getUserProvince().getId(),
                object.getUserCity().getId(),
                object.getUserDistrict().getId(),
                object.getUserAddressDetail(),
                object.getMerchantProvince().getId(),
                object.getMerchantCity().getId(),
                object.getMerchantDistrict().getId(),
                object.getMerchantAddressDetail()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(Orders object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update orders set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String idStr)
    {
        String sql="update orders set enable=0 where id in("+idStr+")";
        return  DBUtils.executeUpdate(sql);
    }

    @Override
    public boolean update(Orders object)
    {
        String sql = "update orders set enable=?,user_id=?,rider_id=?,merchant_id=?"+
                ",user_flag=?,merchant_flag=?,rider_flag=?,reg_time=?,rating=?,rating_description=?,"+
                "order_status=?,total_price=?,complicated_id=? where id=?";
        Object[] params={
                object.getEnable(),
                object.getUser().getId(),
                object.getRider().getId(),
                object.getMerchant().getId(),
                object.getUserFlag(),
                object.getMerchantFlag(),
                object.getRiderFlag(),
                object.getRegTime(),
                object.getRating(),
                object.getRatingDescription(),
                object.getOrderStatus(),
                object.getTotalPrice(),
                object.getComplicatedId(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    public boolean updateUserFlag(Integer id)
    {
        String sql = "update orders set user_flag=1 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    public boolean updateMerchantFlag(Integer id)
    {
        String sql = "update orders set merchant_flag=1 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    public boolean updateRiderFlag(Integer id)
    {
        String sql = "update orders set rider_flag=1 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    public boolean updateTwo(Orders object)
    {
        String sql = "update orders set order_status=? where id=?";
        System.out.println(object.getId());
        Object[] params={
                object.getOrderStatus(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    public boolean cancelOrder(Integer id)
    {
        String sql = "update orders set order_status=2 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    public boolean finishOrder(Orders orders, Integer current_orders, Integer rider_id)
    {
        pay(orders);
        String sql1 = "update rider set current_orders=? where id=?";
        DBUtils.executeUpdate(sql1, current_orders-1, rider_id);
        String sql = "update orders set order_status=1 where id=?";
        return DBUtils.executeUpdate(sql,orders.getId());
    }

    public boolean pay(Orders orders)
    {
        System.out.println(orders);
        BigDecimal userBalance = orders.getUser().getBalance().subtract(orders.getTotalPrice());
        String sql1 = "update user set balance=? where id=?";
        DBUtils.executeUpdate(sql1, userBalance, orders.getUser().getId());
        BigDecimal rate = new BigDecimal(0.9);
        BigDecimal merchantOldBalance = new BigDecimal(orders.getMerchant().getBalance());
        BigDecimal merchantBalance =  merchantOldBalance.add(orders.getTotalPrice().multiply(rate));
        String sql2 = "update merchant set balance=? where id=?";
        DBUtils.executeUpdate(sql2, merchantBalance, orders.getMerchant().getId());
        BigDecimal rate2 = new BigDecimal(0.1);
        BigDecimal riderOldBalance = new BigDecimal(orders.getRider().getBalance());
        BigDecimal riderBalance = riderOldBalance.add(orders.getTotalPrice().multiply(rate2));
        String sql3 = "update rider set balance=? where id=?";
        DBUtils.executeUpdate(sql3, riderBalance, orders.getRider().getId());
        return true;
    }

    @Override
    public Orders findById(Integer id)
    {
        String sql = "select * from orders where enable = 1 and id = ?";
        Connection conn = DBUtils.getConn();
        Orders orders = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs = ps.executeQuery();
            while (rs.next()){
                orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
//              user.setId(rs.getInt("user_id"));
//              rider.setId(rs.getInt("rider_id"));
//              merchant.setId(rs.getInt("merchant_id"));

                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));

                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return orders;
    }

    @Override
    public List<Orders> findAll()
    {
        String sql = "select * from orders where enable=1";
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);
                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }


    public List<Orders> findByOrderStatus(int order_status, int id, String type, PageUtils pageUtils)
    {

        String sql = "select * from orders where enable=1 and order_status=?";
        String countsql = "select count(*) count from orders where enable=1 and order_status="+order_status;
        String whereSql="";
        switch (type)
        {
            case "rider":
                whereSql+=" and rider_id="+id;
                if (order_status == 0)
                {
                    whereSql += " and user_flag=1 and merchant_flag=1 and rider_flag=1";
                }
                break;
            case "merchant":
                whereSql+=" and merchant_id="+id;
                if (order_status == 0)
                {
                    whereSql+= " and user_flag=1 and merchant_flag=1";
                }
                break;
            case "user":
                whereSql+=" and user_id="+id;
                if (order_status == 0)
                {
                    whereSql+= " and user_flag=1";
                }
                break;
        }
        sql+=whereSql;
        sql += " limit ?,?";
        countsql+=whereSql;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, order_status);
            ps.setInt(2, pageUtils.getFirstRow());
            ps.setInt(3, pageUtils.getPageSize());
            rs = ps.executeQuery();

            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);
                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }



//    获得数据总数
    public int getCount(){
        String sql = "select count(*) count from orders where enable =1";
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

    private int getCountWithSql(String sql){

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

//    分页显示订单列表
    public List<Orders> findPage(PageUtils pageUtils){
        List<Orders> ordersList = new ArrayList<>();
        pageUtils.setDataCount(this.getCount());
        String sql = "select * from orders where enable = 1 limit ?,?";
        Connection conn = DBUtils.getConn();
        Orders orders = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                orders = new Orders();

                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                //              user.setId(rs.getInt("user_id"));
                //              rider.setId(rs.getInt("rider_id"));
                //              merchant.setId(rs.getInt("merchant_id"));

                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));

                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return ordersList;
    }


    /**
    * 查询带分页
      */
    public List<Orders> searchOrders(String keywords,PageUtils pageUtils){
        pageUtils.setDataCount(this.getCount(keywords));
        String sql="select * from orders where enable =1";
        if(keywords!=null&&!keywords.equals("")){
            sql+=" and complicated_id like '%"+keywords+"%'";
        }
        sql+=" limit ?,?";
        List<Orders> ordersList = new ArrayList<>();
        Connection conn = DBUtils.getConn();
        Orders orders = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                orders = new Orders();

                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
//              user.setId(rs.getInt("user_id"));
//              rider.setId(rs.getInt("rider_id"));
//              merchant.setId(rs.getInt("merchant_id"));

                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));

                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return ordersList;
    }
/**
 * 获取查询到的条数* */
    public int getCount(String keywords){
        String sql = "select count(*) count from orders";
        sql += " where enable=1 and complicated_id like '%"+keywords+"%'";
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



    /**
     * 查询带分页，加条件
     */
    public List<Orders> searchOrdersByType(String keywords,PageUtils pageUtils,String type, Integer id){

        String sql="select * from orders where enable =1";
        String countsql = "select count(*) count from orders where enable=1";
        String wheresql = "";
        switch (type)
        {
            case "user":
                wheresql += " and user_id=" + id;
                break;
            case "merchant":
                wheresql += " and merchant_id=" + id;
                break;
            case "rider":
                wheresql += " and rider_id=" + id;
                break;
        }
        if(keywords!=null&&!keywords.equals("")){
            wheresql+=" and complicated_id like '%"+keywords+"%'";
        }
        sql+=wheresql;
        sql+=" limit ?,?";
        countsql+=wheresql;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList = new ArrayList<>();
        Connection conn = DBUtils.getConn();
        Orders orders = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                orders = new Orders();

                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
//              user.setId(rs.getInt("user_id"));
//              rider.setId(rs.getInt("rider_id"));
//              merchant.setId(rs.getInt("merchant_id"));

                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));

                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }

        return ordersList;
    }





    public List<Orders> findByRiderId(Integer id, PageUtils pageUtils)
    {
        String sql = "select * from orders where enable=1 and rider_id="+id + " limit ?,?";
        String countsql = "select count(*) count from orders where enable=1 and rider_id="+id;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public List<Orders> findByUserId(Integer userId, PageUtils pageUtils)
    {

        String sql = "select * from orders where enable=1 and user_id="+userId+ " limit ?,?";
        String countsql = "select count(*) count from orders where enable=1 and user_id="+userId;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public List<Orders> findByMerchantId(Integer id, PageUtils pageUtils)
    {
        String sql = "select * from orders where enable=1 and merchant_id="+id+ " limit ?,?";
        String countsql = "select count(*) count from orders where enable=1 and merchant_id="+id;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public List<Orders> findByMerchantIdAndUserFlag(Integer id, PageUtils pageUtils)
    {
        String sql = "select * from orders where enable=1 and user_flag=1 and merchant_flag=0 and order_status=0 and merchant_id="+id+ " limit ?,?";
        String countsql = "select count(*) count from orders where enable=1 and user_flag=1 and merchant_flag=0 and order_status=0 and merchant_id="+id;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public List<Orders> findByRiderIdAndUserFlagAndMerchantFlag(Integer id, PageUtils pageUtils)
    {
        String sql = "select * from orders where enable=1 and order_status=0 and user_flag=1 and merchant_flag=1 and rider_flag=0 and rider_id="+id+ " limit ?,?";
        String countsql = "select count(*) count from orders where enable=1 and order_status=0 and user_flag=1 and merchant_flag=1 and rider_flag=0 and rider_id="+id;
        pageUtils.setDataCount(this.getCountWithSql(countsql));
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public List<Orders> findByRating(Integer rating, PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount());
        String sql = "select * from orders where enable=1 and rating="+rating+ " limit ?,?";
        List<Orders> ordersList= new ArrayList<>();
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try
        {
            ps=conn.prepareStatement(sql);
            ps.setInt(1, pageUtils.getFirstRow());
            ps.setInt(2, pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next())
            {
                Orders orders = new Orders();
                User user = UserDAOImpl.getDAO().findById(rs.getInt("user_id"));
                Merchant merchant = MerchantDAOImpl.getDao().findById(rs.getInt("merchant_id"));
                Rider rider = RiderDAOImpl.getRiderDAO().findById(rs.getInt("rider_id"));
                orders.setEnable(rs.getBoolean("enable"));
                orders.setId(rs.getInt("id"));
                orders.setRegTime(rs.getTimestamp("reg_time"));
                orders.setOrderStatus(rs.getInt("order_status"));
                orders.setMerchantFlag(rs.getInt("merchant_flag"));
                orders.setRiderFlag(rs.getInt("rider_flag"));
                orders.setUserFlag(rs.getInt("user_flag"));
                orders.setRating(rs.getInt("rating"));
                orders.setRatingDescription(rs.getString("rating_description"));
                orders.setTotalPrice(rs.getBigDecimal("total_price"));
                orders.setComplicatedId(rs.getString("complicated_id"));
                orders.setUser(user);
                orders.setRider(rider);
                orders.setMerchant(merchant);

                orders.setUserAddressDetail(rs.getString("user_address_detail"));
                orders.setMerchantAddressDetail(rs.getString("merchant_address_detail"));
                SysArea userProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("user_province_id")));
                SysArea userCity = (SysAreaDAOImpl.getDao().findById(rs.getString("user_city_id")));
                SysArea userDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("user_district_id")));
                SysArea merchantProvince = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_province_id")));
                SysArea merchantCity = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_city_id")));
                SysArea merchantDistrict = (SysAreaDAOImpl.getDao().findById(rs.getString("merchant_district_id")));
                orders.setUserProvince(userProvince);
                orders.setUserCity(userCity);
                orders.setUserDistrict(userDistrict);
                orders.setMerchantProvince(merchantProvince);
                orders.setMerchantCity(merchantCity);
                orders.setMerchantDistrict(merchantDistrict);
                ordersList.add(orders);
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
        return ordersList;
    }

    public boolean distributeOrders(Integer orderId, String district_id)
    {
        List<Rider> riderList = RiderDAOImpl.getRiderDAO().findByDistrictId(district_id);
        HashMap<Integer, Integer> mapRiderIdWithCurrentOrder = new HashMap<>();
        for (Rider rider:riderList)
        {
            mapRiderIdWithCurrentOrder.put(rider.getId(), rider.getCurrent_orders());
        }
        int sum = 0;
        for (int value : mapRiderIdWithCurrentOrder.values()) {
            sum += value;
        }
        int average = sum/mapRiderIdWithCurrentOrder.size();
        for (Map.Entry<Integer, Integer> entry : mapRiderIdWithCurrentOrder.entrySet()) {
            int key = entry.getKey();
            int value = entry.getValue();
            if (value <= average)
            {
                String sql = "update rider set current_orders=? where id=?";
                DBUtils.executeUpdate(sql, value+1, key);
                String sql2 = "update orders set rider_id=? where id=?";
                DBUtils.executeUpdate(sql2, key, orderId);
                return true;
            }
        }
        return false;
    }

    public Orders findNewAdd(){
        String sql = "select * from Orders order by id DESC limit 1";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Orders orders = null;

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if(rs.next()){
                orders = new Orders();
                orders.setId(rs.getInt("id"));
                orders.setComplicatedId(rs.getString("complicated_id"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return orders;
    }

    public boolean updateStatus(int status,String orderNo){
        String sql="update orders set user_flag=? where complicated_id=?";
        return DBUtils.executeUpdate(sql,status,orderNo);
    }
}


