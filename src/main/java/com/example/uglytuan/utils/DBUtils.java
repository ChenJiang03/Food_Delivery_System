package com.example.uglytuan.utils;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;

public class DBUtils
{

    //获得连接
    public static Connection getConn(){
        Connection conn=null;
        PreparedStatement ps=null;
        String url="jdbc:mysql://localhost:3306/uglytuan?useUnicode=true&useSSL=false&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true";
        String user="root";
        String pass="wanmait";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection(url,user,pass);
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        return conn;
    }
    //关闭连接
    public static void closeConn(ResultSet rs, PreparedStatement ps, Connection conn){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        if(ps!=null){
            try {
                ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    //执行增删改
    public static boolean executeUpdate(String sql,Object... params){
        Connection conn=getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        try{
            ps=conn.prepareStatement(sql);
            for(int i=0;i<params.length;i++){
                ps.setObject(i+1,params[i]);
            }
            return ps.executeUpdate()>0;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            closeConn(rs,ps,conn);
        }
        return false;
    }

    public static Object executeQuerySingle(String sql,Class clazz,Object... params)  {
        Connection conn=getConn();
        PreparedStatement ps=null;
        ResultSet rs=null;
        Object o=null;
        try {
            ps=conn.prepareStatement(sql);
            for(int i=0;i<params.length;i++){
                ps.setObject(i+1,params[i]);
            }
            rs=ps.executeQuery();
            ResultSetMetaData rsmd=rs.getMetaData();
            //获得从数据库中读取列的数量
            int count=rsmd.getColumnCount();
            //获得无参的构造函数
            Constructor constructor=clazz.getConstructor();
            //通过构造函数获得对象
            o=constructor.newInstance();
            if(rs.next()){
                //通过Class获得所有的属性
                Field[] fields=clazz.getDeclaredFields();
                //循环所有的属性
                for(Field f:fields){
                    //获得访问私有属性的权限
                    f.setAccessible(true);
                    //循环数据库中所有的列
                    for(int i=0;i<count;i++){
                        //获得指定列的名字（不支持别名）
                        //String columnName=rsmd.getColumnName(i+1);
                        //获得指定列的标签名（支持别名）
                        String columnLabel=rsmd.getColumnLabel(i+1);
                        //获得指定类在数据中的类型
                        String columnTypeName=rsmd.getColumnTypeName(i+1);
                        //如果从数据库中读出来的标签名和属性名相同
                        if(columnLabel.replace("_","").equalsIgnoreCase(f.getName())){
                                Object value=rs.getObject(columnLabel);
                                f.set(o,value);

                        }
                    }
                }
            }

        } catch (Exception throwables) {
            throwables.printStackTrace();
        } finally {
            closeConn(rs,ps,conn);
        }
        return o;
    }
}
