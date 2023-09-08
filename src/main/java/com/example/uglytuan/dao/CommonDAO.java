package com.example.uglytuan.dao;

import java.util.List;

public interface CommonDAO<T>
{
    boolean add(T object);
    boolean delete(T object);
    boolean delete(Integer id);
    boolean delete(String ids);
    boolean update(T object);
    T findById(Integer id);
    List<T> findAll();

}
