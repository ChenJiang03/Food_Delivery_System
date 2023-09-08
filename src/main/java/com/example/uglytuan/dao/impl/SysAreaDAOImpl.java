package com.example.uglytuan.dao.impl;

import com.example.uglytuan.dao.SysAreaDAO;
import com.example.uglytuan.utils.DBUtils;
import com.example.uglytuan.vo.Merchant;
import com.example.uglytuan.vo.SysArea;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SysAreaDAOImpl implements SysAreaDAO
{
    private SysAreaDAOImpl(){}
    private static SysAreaDAOImpl dao = new SysAreaDAOImpl();

    public static SysAreaDAOImpl getDao()
    {
        return dao;
    }

    @Override
    public boolean add(SysArea object)
    {
        return false;
    }

    @Override
    public boolean delete(SysArea object)
    {
        return false;
    }

    @Override
    public boolean delete(Integer id)
    {
        return false;
    }

    @Override
    public boolean delete(String ids)
    {
        return false;
    }

    @Override
    public boolean update(SysArea object)
    {
        return false;
    }

    @Override
    public SysArea findById(Integer id)
    {
        return null;
    }

    @Override
    public List<SysArea> findAll() {
        return null;
    }

    @Override
    public List<SysArea> findAll(String parentId){
        String sql="select * from sys_area where parent_id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        List<SysArea> sysAreaList=new ArrayList<>();
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,parentId);
            rs= ps.executeQuery();
            while (rs.next()){
                SysArea sysArea=new SysArea();
                sysArea.setId(rs.getString("id"));
                sysArea.setName(rs.getString("name"));
                sysArea.setParentId(rs.getString("parent_id"));
                sysAreaList.add(sysArea);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            DBUtils.closeConn(rs,ps,conn);
        }
        return sysAreaList;
    }

    @Override
    public SysArea findById(String id){
        String sql="select * from sys_area where id=?";
        Connection conn= DBUtils.getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        SysArea sysArea=new SysArea();
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,id);
            rs= ps.executeQuery();
            if (rs.next()){
                sysArea.setId(rs.getString("id"));
                sysArea.setName(rs.getString("name"));
                sysArea.setParentId(rs.getString("parent_id"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally{
            DBUtils.closeConn(rs,ps,conn);
        }
        return sysArea;
    }
}
