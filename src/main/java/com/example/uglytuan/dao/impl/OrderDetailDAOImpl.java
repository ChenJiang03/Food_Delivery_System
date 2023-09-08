package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.OrderDetailDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.OrderDetail;
import com.example.uglytuan.vo.Orders;
import com.example.uglytuan.vo.Product;
import com.example.uglytuan.vo.User;
import com.mysql.cj.x.protobuf.MysqlxCrud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO
{

    private static OrderDetailDAOImpl orderDetailDAO = new OrderDetailDAOImpl();
    private OrderDetailDAOImpl(){}
    public static OrderDetailDAOImpl getDAO(){
        return orderDetailDAO;

    }


    @Override
    public boolean add(OrderDetail object)
    {
        String sql = "insert into order_detail(product_id,order_id,price,amount) values(?,?,?,?)";
        Object[] params={
                object.getProduct().getId(),
                object.getOrder().getId(),
                object.getPrice(),
                object.getAmount()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(OrderDetail object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update order_detail set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql = "update order_detail set enable=0 where id in ("+ids+")";
//        Object[] params = ids.split(",");
        return DBUtils.executeUpdate(sql);
    }

    @Override
    public boolean update(OrderDetail object)
    {

        return false;
    }

    @Override
    public OrderDetail findById(Integer id)
    {
        return null;
    }

    @Override
    public List<OrderDetail> findAll()
    {
        return null;
    }


    public int getCount(int orderId){
        String sql = "select count(*) count from order_detail where enable =1 and order_id = ?";
        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,orderId);
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

/*
* 订单查询，分页
* pageUtils 工具类
* 返回OrderDetail类型数组*   */
    public List<OrderDetail> findPage(PageUtils pageUtils,int OrdersId) {
        List<OrderDetail> orderDetailList = new ArrayList<>();
        pageUtils.setDataCount(this.getCount(OrdersId));
        String sql = "select * from order_detail where enable = 1 and order_id =? LIMIT ?,?";
        Connection conn = DBUtils.getConn();
        OrderDetail orderDetail= null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,OrdersId);
            ps.setInt(2,pageUtils.getFirstRow());
            ps.setInt(3,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                orderDetail = new OrderDetail();
                Orders orders = OrdersDAOImpl.getDao().findById(OrdersId);
                Product product = ProductDAOImpl.getDao().findById(rs.getInt("product_id"));
                orderDetail.setId(rs.getInt("id"));
                orderDetail.setProduct(product);
                orderDetail.setEnable(rs.getBoolean("enable"));
                orderDetail.setAmount(rs.getInt("amount"));
                orderDetail.setPrice(rs.getDouble("price"));
                orderDetail.setOrder(orders);

                orderDetailList.add(orderDetail);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  orderDetailList;
    }


//    订单详情的查询
    /**
     * 待商榷* */
    public List<OrderDetail> search(PageUtils pageUtils,int OrdersId,String keywords){
        List<OrderDetail> orderDetailList = new ArrayList<>();
        pageUtils.setDataCount(this.getCount(OrdersId));
        String sql = "select * from order_detail where enable = 1 and order_id =? LIMIT ?,?";
        if(keywords!=null&&!keywords.equals("")){
            sql+=" and complicated_id like '%"+keywords+"%'";
        }
        Connection conn = DBUtils.getConn();
        OrderDetail orderDetail= null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,OrdersId);
            ps.setInt(2,pageUtils.getFirstRow());
            ps.setInt(3,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while (rs.next()){
                orderDetail = new OrderDetail();
                Orders orders = OrdersDAOImpl.getDao().findById(OrdersId);
                Product product = ProductDAOImpl.getDao().findById(rs.getInt("product_id"));
                orderDetail.setId(rs.getInt("id"));
                orderDetail.setProduct(product);
                orderDetail.setEnable(rs.getBoolean("enable"));
                orderDetail.setAmount(rs.getInt("amount"));
                orderDetail.setPrice(rs.getDouble("price"));
                orderDetail.setOrder(orders);

                orderDetailList.add(orderDetail);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  orderDetailList;

    }

    public List<OrderDetail> findByOrderId(Integer orderId){
        List<OrderDetail> orderDetailList = new ArrayList<>();
        String sql = "select * from order_detail where enable = 1 and order_id ="+orderId;
        Connection conn = DBUtils.getConn();
        OrderDetail orderDetail= null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                orderDetail = new OrderDetail();
                Orders orders = OrdersDAOImpl.getDao().findById(orderId);
                Product product = ProductDAOImpl.getDao().findById(rs.getInt("product_id"));
                orderDetail.setId(rs.getInt("id"));
                orderDetail.setProduct(product);
                orderDetail.setEnable(rs.getBoolean("enable"));
                orderDetail.setAmount(rs.getInt("amount"));
                orderDetail.setPrice(rs.getDouble("price"));
                orderDetail.setOrder(orders);
                orderDetailList.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return  orderDetailList;

    }

}
