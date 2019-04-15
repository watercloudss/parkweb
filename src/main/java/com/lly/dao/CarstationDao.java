package com.lly.dao;

import com.lly.po.Carstation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarstationDao {
    public int insertCarstation(Carstation carstation);

    public int deleteCarstation(@Param("id") int id);

    public int selectByCode(@Param("code") String code);

    public int count();

    public int updateCarstation(Carstation carstation);

    public int updateCarstationTotal(Carstation carstation);

    public List<Carstation> cList();
}
