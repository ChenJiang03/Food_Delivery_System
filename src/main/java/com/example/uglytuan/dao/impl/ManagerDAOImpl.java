package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.ManagerDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.utils.PageUtils;
import com.example.uglytuan.vo.Manager;

import javax.print.attribute.standard.MediaName;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAOImpl implements ManagerDAO
{
//实现单例
    private  static  ManagerDAOImpl managerDAO = new ManagerDAOImpl();
    private ManagerDAOImpl(){}
    public static ManagerDAOImpl getManagerDAO(){
        return managerDAO;
    }
    public  Manager login(String username,String password){
        String sql = "select * from manager where username =? and password =?";
        Manager manager =null;
        Connection con= DBUtils.getConn();
        PreparedStatement pr = null;
        ResultSet rs = null;
        try {
            pr = con.prepareStatement(sql);
            pr.setString(1,username);
            pr.setString(2,password);
            rs = pr.executeQuery();
            while(rs.next()){
                manager =new Manager();
                manager.setId(rs.getInt("id"));
                manager.setUsername(rs.getString("username"));
                manager.setPassword(rs.getString("password"));
                manager.setSuperManager(rs.getBoolean("super_manager"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeConn(rs,pr,con);
        }
        return manager;
    }


    @Override
    public boolean add(Manager object)
    {
        String sql = "insert into manager(username,password) values(?,?)";
        Object[] params = {
                object.getUsername(),
                object.getPassword()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public boolean delete(Manager object)
    {

        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        String sql = "update manager set enable=0 where id=?";
        return DBUtils.executeUpdate(sql,id);
    }

    @Override
    public boolean delete(String ids)
    {
        String sql="update manager set enable=0 where id in("+ids+")";

        return  DBUtils.executeUpdate(sql);

    }

    @Override
    public boolean update(Manager object)
    {
        String sql = "update manager set username=?,password=? where id=?";
        Object[] params={
                object.getUsername(),
                object.getPassword(),
                object.getId()
        };
        return DBUtils.executeUpdate(sql,params);
    }

    @Override
    public Manager findById(Integer id)
    {
        String sql = "select * from manager where id=?";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Manager manager = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,id);
            rs = ps.executeQuery();

            while(rs.next()){
                manager = new Manager();
                manager.setUsername(rs.getString("username"));
                manager.setPassword(rs.getString("password"));
                manager.setId(rs.getInt("id"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return manager;
    }

    @Override
    public List<Manager> findAll() {
        return null;
    }

    @Override
    public List<Manager> findAll(PageUtils pageUtils)
    {
        pageUtils.setDataCount(this.getCount());
        List<Manager> managerList = new ArrayList<>();
        String sql = "select * from manager where enable=1 and super_manager=0 limit ?,?";

        Connection conn = DBUtils.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,pageUtils.getFirstRow());
            ps.setInt(2,pageUtils.getPageSize());
            rs = ps.executeQuery();
            while(rs.next()){
                Manager manager = new Manager();
                manager.setId(rs.getInt("id"));
                manager.setPassword(rs.getString("password"));
                manager.setUsername(rs.getString("username"));
                manager.setSuperManager(rs.getBoolean("super_manager"));
                managerList.add(manager);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return managerList;
    }

    @Override
    public List<Manager> search(String keywords,PageUtils pageUtils){
        pageUtils.setDataCount(this.getCount(keywords));
        List<Manager> managerList = new ArrayList<>();
        String sql = "select * from manager where enable=1 and super_manager=0";
        if(keywords!=null&&!keywords.equals("")){
             sql += " and username like '%"+keywords+"%'";
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
                Manager manager = new Manager();
                manager.setId(rs.getInt("id"));
                manager.setUsername(rs.getString("username"));
                manager.setPassword(rs.getString("password"));
                managerList.add(manager);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            DBUtils.closeConn(rs,ps,conn);
        }
        return managerList;
    }

    public int getCount(){
        String sql="SELECT count(*) count from manager where enable=1 and super_manager=0";
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

    public int getCount(String keywords){
        String sql="SELECT count(*) count from manager where enable=1 and super_manager=0 and username like '%"+keywords+"%'";
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
    public boolean existManager(String username){
        String sql = "select count(*) count from manager where username=? and enable=1 and super_manager=0";
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
}
